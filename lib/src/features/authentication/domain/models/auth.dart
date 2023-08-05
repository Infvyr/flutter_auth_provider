import 'dart:convert' show json;

import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String? token;

  const Auth({this.token});

  factory Auth.fromMap(Map<String, dynamic> data) => Auth(
        token: data['token'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'token': token,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Auth].
  factory Auth.fromJson(String data) {
    return Auth.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Auth] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [token];
}
