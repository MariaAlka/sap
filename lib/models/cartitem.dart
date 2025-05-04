// lib/models/cart_item.dart
import 'product_model.dart';

class CartItem {
  final Product product;
  double quantity;
  String? color;
  String? size;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.color,
    this.size,
  });

  double get totalPrice => product.price * quantity;
}
