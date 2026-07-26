import 'dart:io';
import '../models/country_involvement.dart';
import 'barcode_lookup_service.dart';
import 'gemini_service.dart';

class ProductAnalysisService {
  final BarcodeLookupService _barcodeLookup;
  final GeminiService _gemini;

  ProductAnalysisService()
      : _barcodeLookup = BarcodeLookupService(),
        _gemini = GeminiService();

  Future<AnalysisResult> analyzeByBarcode(String barcode) async {
    final product = await _barcodeLookup.lookupBarcode(barcode);
    return _gemini.analyzeProduct(product: product);
  }

  Future<AnalysisResult> analyzeByImage(File imageFile) async {
    return _gemini.analyzeProduct(imageFile: imageFile);
  }

  Future<AnalysisResult> analyzeByBarcodeAndImage({
    required String barcode,
    required File imageFile,
  }) async {
    final product = await _barcodeLookup.lookupBarcode(barcode);
    return _gemini.analyzeProduct(product: product, imageFile: imageFile);
  }
}
