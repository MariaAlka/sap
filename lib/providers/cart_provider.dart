import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../models/product_model.dart';
import '../locator.dart';

class CartProvider with ChangeNotifier {
  final CartService _cartService = locator<CartService>();

  Map<Product, int> get cartItems => _cartService.cartItems;

  void addToCart(Product product) {
    _cartService.addToCart(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartService.removeFromCart(product);
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    _cartService.updateQuantity(product, quantity);
    notifyListeners();
  }

  void clearCart() {
    _cartService.clearCart();
    notifyListeners();
  }

  double get totalPrice => _cartService.getTotalPrice();
}
