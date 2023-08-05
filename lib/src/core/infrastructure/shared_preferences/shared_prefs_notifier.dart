import 'package:flutter/foundation.dart';

class SharedPrefsNotifier extends ChangeNotifier{
  bool _isAuthenticated = false;
  
  bool get isAuthenticated => _isAuthenticated;
  
  void init({String? token}) {
    if (token != null && token.isNotEmpty) {
      _isAuthenticated = true;
      notifyListeners();
    }
  }
}
