import 'package:flutter/widgets.dart';
import 'package:flutter_authentication/src/features/index.dart';
import 'package:flutter_authentication/src/pages/index.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const SplashPage(),
  '/sign-in': (context) => const SignInPage(),
  '/sign-up': (context) => const SignUpPage(),
};
