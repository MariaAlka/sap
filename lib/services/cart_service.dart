// lib/services/cart_service.dart
import '../models/product_model.dart';

class CartService {
  static final CartService _instance = CartService._internal();

  factory CartService() => _instance;

  CartService._internal();

  final Map<Product, int> _cartItems = {};

  Map<Product, int> get cartItems => _cartItems;

  void addToCart(Product product) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + 1;
    } else {
      _cartItems[product] = 1;
    }
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      removeFromCart(product);
    } else {
      _cartItems[product] = quantity;
    }
  }

  void clearCart() {
    _cartItems.clear();
  }

  double getTotalPrice() {
    return _cartItems.entries
        .fold(0, (sum, entry) => sum + entry.key.price * entry.value);
  }
}
