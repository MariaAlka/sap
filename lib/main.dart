import 'package:first/screens/cart_page.dart';
import 'package:first/screens/product_page.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'services/auth_service.dart';

void main() {
  runApp(MyApp(authService: AuthService()));
}

class MyApp extends StatelessWidget {
  final AuthService authService;

  const MyApp({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      routes: {
        '/login': (context) => LoginScreen(authService: authService),
        '/home': (context) => ProductsPage(authService: authService),
        '/cart': (context) => const CartPage(),
      },
      home: FutureBuilder(
        future: authService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          return snapshot.data == true
              ? LoginScreen(authService: authService)
              : LoginScreen(authService: authService);
        },
      ),
    );
  }
}