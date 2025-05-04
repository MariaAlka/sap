import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthService() {
    _dio.options.baseUrl = 'https://dummyjson.com';
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<bool> login(String username, String password, {int expiresInMins = 30}) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
          'expiresInMins': expiresInMins,
        },
        options: Options(
          extra: {'withCredentials': true}, // Equivalent to credentials: 'include'
        ),
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        await _storage.write(key: 'jwt_token', value: token);
        return true;
      }
      return false;
    } on DioException catch (e) {
      print('Login error: ${e.response?.data}');
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'jwt_token');
    if (token == null) return false;

    return !JwtDecoder.isExpired(token);
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');

  }

  Future<Map<String, dynamic>?> getUserData() async {
    final token = await getToken();
    if (token == null) return null;

    return JwtDecoder.decode(token);
  }
}