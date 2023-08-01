import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_authentication/src/core/infrastructure/dio/dio.dart';
import 'package:flutter_authentication/src/features/authentication/domain/models/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthNotifier extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  bool _isAuthenticated = false;
  String _token = '';

  bool get isAuthenticated => _isAuthenticated;
  String get token => _token;

  void init({String? token}) {
    if (token != null && token.isNotEmpty) {
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<Auth> signIn({
    required Map data,
    Function? onSuccess,
    Function? onError,
  }) async {
    try {
      final response = await dio.post(
        '/login',
        data: jsonEncode(data),
      );
      final responseData = response.data as Map<String, dynamic>;

      if (response.statusCode == HttpStatus.ok) {
        _token = responseData['token'];

        _saveToken(token);
        _isAuthenticated = true;
        notifyListeners();

        onSuccess?.call();
        return Auth.fromJson(jsonEncode(responseData));
      } else {
        throw 'Something went wrong!';
      }
    } on DioException catch (error) {
      if (error.response != null) {
        final errorData = error.response!.data;
        final errorMessage = errorData['error'] as String;
        onError?.call(errorMessage);
      } else {
        onError?.call(error.message);
      }
      rethrow;
    } catch (error) {
      onError?.call(error.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    _deleteToken();
    notifyListeners();
  }

  void _saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  void _deleteToken() async {
    _isAuthenticated = false;
    await storage.delete(key: 'token');
  }

  Future<void> checkToken() async {
    await storage.read(key: 'token').then((token) {
      if (token != null && token.isNotEmpty) {
        _isAuthenticated = true;
        _token = token;
        notifyListeners();
      } else {
        _isAuthenticated = false;
        _token = '';
        notifyListeners();
      }
    });
  }
}