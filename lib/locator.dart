import 'package:get_it/get_it.dart';
import 'services/auth_service.dart';
import 'services/cart_service.dart';
import 'services/product_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<CartService>(() => CartService());
  locator.registerLazySingleton<ProductService>(() => ProductService());
}
