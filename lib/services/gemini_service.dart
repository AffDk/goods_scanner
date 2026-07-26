import 'dart:convert';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/env.dart';
import '../models/country_involvement.dart';
import '../models/product.dart';

class GeminiService {
  GenerativeModel? _model;

  Future<AnalysisResult> analyzeProduct({
    Product? product,
    File? imageFile,
  }) async {
    final apiKey = Env.geminiApiKey;
    if (apiKey.isEmpty) {
      return AnalysisResult(
        product: product,
        countries: [
          CountryInvolvement(
            countryName: 'Setup Required',
            percentage: 100.0,
            role: 'Add Gemini API key in .env file',
          ),
        ],
        summary: 'Open .env and set GEMINI_API_KEY. See docs/API_SETUP.md for instructions.',
        benefitingCountry: 'N/A',
      );
    }

    _model ??= GenerativeModel(
      model: 'gemini-3.5-flash',
      apiKey: apiKey,
    );

    final content = _buildPrompt(product);
    final parts = <Part>[_textPart(content)];

    if (imageFile != null) {
      parts.insert(0, await _imagePart(imageFile));
    }

    final response = await _model!.generateContent([Content.multi(parts)]);
    final text = response.text ?? '';

    return _parseResponse(text, product);
  }

  String _buildPrompt(Product? product) {
    final buffer = StringBuffer();
    buffer.writeln('You are a global supply chain analyst. Analyze this product and determine which countries are involved in its production and supply chain.');
    buffer.writeln('');
    buffer.writeln('Return a JSON object with EXACTLY this structure (no markdown, no backticks, pure JSON):');
    buffer.writeln('{');
    buffer.writeln('  "countries": [');
    buffer.writeln('    {"country": "Country Name", "percentage": 45.0, "role": "Manufacturing / Design / Raw Materials / Assembly / Retail Profit"},');
    buffer.writeln('    {"country": "Country Name", "percentage": 35.0, "role": "Role description"},');
    buffer.writeln('    {"country": "Country Name", "percentage": 20.0, "role": "Role description"}');
    buffer.writeln('  ],');
    buffer.writeln('  "summary": "Brief explanation of the supply chain breakdown",');
    buffer.writeln('  "benefiting_country": "The country that likely benefits most financially"');
    buffer.writeln('}');
    buffer.writeln('');
    buffer.writeln('Rules:');
    buffer.writeln('- Show up to 3 countries, percentages must add up to 100%');
    buffer.writeln('- Base analysis on the product details and your knowledge of global supply chains');
    buffer.writeln('- "benefiting_country" is where the profit likely flows to (headquarters, IP owner)');
    buffer.writeln('- Use only the JSON format above, no other text');

    if (product != null) {
      buffer.writeln('');
      buffer.writeln('Product details:');
      if (product.barcode != null) buffer.writeln('Barcode: ${product.barcode}');
      if (product.name != null) buffer.writeln('Name: ${product.name}');
      if (product.brand != null) buffer.writeln('Brand: ${product.brand}');
      if (product.category != null) buffer.writeln('Category: ${product.category}');
      if (product.manufacturerCountry != null) buffer.writeln('Manufacturer country: ${product.manufacturerCountry}');
      if (product.ingredientSources.isNotEmpty) buffer.writeln('Ingredient sources: ${product.ingredientSources.join(", ")}');
    }

    return buffer.toString();
  }

  TextPart _textPart(String text) => TextPart(text);

  Future<DataPart> _imagePart(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return DataPart('image/jpeg', bytes);
  }

  AnalysisResult _parseResponse(String text, Product? product) {
    try {
      // Try to extract JSON from the response (handle markdown code blocks)
      String jsonStr = text.trim();
      if (jsonStr.startsWith('```')) {
        final lines = jsonStr.split('\n');
        lines.removeAt(0);
        jsonStr = lines.join('\n');
        if (jsonStr.endsWith('```')) {
          jsonStr = jsonStr.substring(0, jsonStr.length - 3);
        }
      }
      jsonStr = jsonStr.trim();

      final json = jsonDecode(jsonStr) as Map<String, dynamic>;
      return AnalysisResult.fromJson({
        ...json,
        'product': product?.toJson(),
      });
    } catch (e) {
      // Fallback: return a basic result
      return AnalysisResult(
        product: product,
        countries: [
          CountryInvolvement(countryName: 'Unknown', percentage: 100.0, role: 'Unable to determine'),
        ],
        summary: 'Could not parse AI response. Please try again.',
        benefitingCountry: 'Unknown',
      );
    }
  }
}
