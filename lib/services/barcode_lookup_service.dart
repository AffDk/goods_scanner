import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class BarcodeLookupService {
  static const String _openFoodFactsUrl = 'https://world.openfoodfacts.org/api/v2/product';

  Future<Product?> lookupBarcode(String barcode) async {
    final product = await _lookupOpenFoodFacts(barcode);
    return product;
  }

  Future<Product?> _lookupOpenFoodFacts(String barcode) async {
    try {
      final uri = Uri.parse('$_openFoodFactsUrl/$barcode.json');
      final response = await http.get(
        uri,
        headers: {'User-Agent': 'GoodsScanner/1.0'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['status'] == 1) {
          return Product.fromJson(data['product'] as Map<String, dynamic>);
        }
      }
    } catch (e) {
      // Fall through to return null
    }
    return null;
  }
}
