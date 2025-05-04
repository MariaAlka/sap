import 'package:first/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'locator.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';

import 'screens/login_screen.dart';
import 'screens/product_page.dart';
import 'screens/product_details_page.dart';
import 'screens/cart_page.dart';
import 'models/product_model.dart';

void main() {
  setupLocator(); // <-- ADD THIS LINE!
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MyApp(authService: locator<AuthService>()),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthService authService;

  const MyApp({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(authService: authService),
        '/products': (context) => ProductsPage(authService: authService),
        '/cart': (context) => const CartPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/product_details') {
          final product = settings.arguments as Product;
          return MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: product),
          );
        }
        return null;
      },
    );
  }
}
