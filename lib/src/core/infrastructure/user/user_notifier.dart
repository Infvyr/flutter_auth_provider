import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_authentication/src/core/index.dart';

class UserNotifier extends ChangeNotifier {
  late User _user;

  User get user => _user;

  Future<User> getUser({required int userId}) async {
    try {
      final response = await dio.get('/users/$userId');
      final responseData = response.data['data'] as Map<String, dynamic>;

      if (response.statusCode == HttpStatus.ok) {
        _user = User.fromJson(responseData);
        await SharedPrefs.saveMapData('user', responseData);
        notifyListeners();
      } else {
        throw 'Failed to fetch user data!';
      }
    } on DioException catch (error) {
      if (error.response != null) {
        final errorData = error.response!.data;
        final errorMessage = errorData['error'] as String;
        throw errorMessage;
      } else {
        rethrow;
      }
    } catch (error) {
      rethrow;
    }
    return _user;
  }

  Future<User> readUserData() async {
    try {
      final userData = SharedPrefs.getMapData('user');
      _user = User.fromJson(userData);
      return _user;
    } catch (error) {
      rethrow;
    }
  }
}
