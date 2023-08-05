import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesNotifier extends ChangeNotifier {
  SharedPreferencesNotifier({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  bool get isDarkModeEnabled => _sharedPreferences.getBool(_kIsDarkModeEnabled) ?? false;

  set isDarkModeEnabled(bool value) {
    _sharedPreferences.setBool(_kIsDarkModeEnabled, value);
    notifyListeners();
  }

  static const _kIsDarkModeEnabled = 'isDarkModeEnabled';
}
