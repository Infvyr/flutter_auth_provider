import 'dart:io';

import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:dio/dio.dart';
import 'package:flutter_authentication/src/core/index.dart';

class UserNotifier extends ChangeNotifier {
  User _user = const User(
    id: 0,
    firstName: 'Mark',
    lastName: 'Njunge',
    avatar: 'https://reqres.in/img/faces/1-image.jpg',
    email: 'email@domain.com',
  );

  User get user => _user;

  Future<User> getUser({required int userId}) async {
    try {
      final response = await dio.get('/users/$userId');
      final responseData = response.data['data'] as Map<String, dynamic>;

      if (response.statusCode == HttpStatus.ok) {
        _user = User.fromJson(responseData);
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
}
