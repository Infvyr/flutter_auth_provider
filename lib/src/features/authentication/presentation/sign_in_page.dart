import 'package:flutter/material.dart';
import 'package:flutter_authentication/src/features/authentication/presentation/auth_form_footer.dart';
import 'package:flutter_authentication/src/features/authentication/presentation/auth_form_header.dart';
import 'package:flutter_authentication/src/features/authentication/presentation/sign_in_form.dart';
import 'package:flutter_authentication/src/features/authentication/presentation/sign_up_page.dart';

class SignInPage extends StatelessWidget {
  static String routeName = '/sign-in';

  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AuthFormHeader(
            title: 'Welcome Back',
          ),
          const SignInForm(),
          AuthFormFooter(
            title: "Don't have an account?",
            buttonText: 'Sign up now',
            onPressed: () => Navigator.of(context).popAndPushNamed(SignUpPage.routeName),
          ),
        ],
      ),
    );
  }
}
