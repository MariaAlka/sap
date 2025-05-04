import 'package:flutter/material.dart';
import '../services/product_service.dart';
import '../models/product_model.dart';
import '../locator.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = locator<ProductService>();

  List<Product> _products = [];
  bool _loading = false;

  List<Product> get products => _products;
  bool get isLoading => _loading;

  Future<void> fetchProducts() async {
    _loading = true;
    notifyListeners();

    try {
      _products = await _productService.fetchProducts();
    } catch (e) {
      print('Product fetch error: $e');
    }

    _loading = false;
    notifyListeners();
  }
}
