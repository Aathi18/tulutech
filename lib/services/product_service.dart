import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String baseUrl = 'https://dummyjson.com/products';

  // Fetches products using limit and skip for pagination
  Future<List<Product>> fetchProducts({required int skip, int limit = 30}) async {
    final url = Uri.parse('$baseUrl?limit=$limit&skip=$skip'); 
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List productsJson = data['products'];
      // Check if total count is reached (no more products to load)
      if (productsJson.isEmpty) return []; 
      
      return productsJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }
}