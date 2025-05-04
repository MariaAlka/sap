import 'package:first/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';

import 'screens/login_screen.dart';
import 'screens/product_page.dart';
import 'screens/product_details_page.dart';
import 'screens/cart_page.dart'; // If you're using the cart page

void main() {
  final authService = AuthService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MyApp(authService: authService),
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
        '/login': (context) => LoginScreen(authService: authService), // 👈 Pass it
        '/products': (context) => ProductsPage(authService: authService),
        '/cart': (context) => const CartPage(),
        // You can add product details navigation via `Navigator.pushNamed(context, '/product_details', arguments: product);`
      },
    );
  }
}
