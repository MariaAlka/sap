import 'package:flutter/foundation.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  final Map<Product, int> _cartItems = {};

  Map<Product, int> get cartItems => _cartItems;

  void addToCart(Product product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
    } else {
      _cartItems[product] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      removeFromCart(product);
    } else {
      _cartItems[product] = quantity;
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.entries.fold(
      0.0,
          (sum, entry) => sum + entry.key.price * entry.value,
    );
  }
}
