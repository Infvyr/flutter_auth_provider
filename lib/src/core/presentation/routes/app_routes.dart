import 'package:flutter/widgets.dart';
import 'package:flutter_authentication/src/features/authentication/presentation/sign_in_page.dart';
import 'package:flutter_authentication/src/features/authentication/presentation/sign_up_page.dart';
import 'package:flutter_authentication/src/pages/splash_page/presentation/splash_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const SplashPage(),
  '/sign-in': (context) => const SignInPage(),
  '/sign-up': (context) => const SignUpPage(),
};
