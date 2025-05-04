import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductService {
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get('https://dummyjson.com/products');
      final List products = response.data['products'];
      return products.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
