import 'package:flutter/material.dart';
import 'package:flutter_authentication/src/features/authentication/presentation/auth_form_footer.dart';
import 'package:flutter_authentication/src/features/authentication/presentation/sign_in_form.dart';
import 'package:flutter_authentication/src/features/authentication/presentation/auth_form_header.dart';
import 'package:flutter_authentication/src/features/authentication/presentation/sign_in_page.dart';

class SignUpPage extends StatelessWidget {
  static String routeName = '/sign-up';

  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AuthFormHeader(
            title: 'Create an account',
          ),
          const Text(
            'Duplicate sign in form here\njust for demo purposes',
            textAlign: TextAlign.center,
          ),
          const SignInForm(),
          AuthFormFooter(
            title: 'Have an account already?',
            buttonText: 'Sign in now',
            onPressed: () => Navigator.of(context).popAndPushNamed(SignInPage.routeName),
          ),
        ],
      ),
    );
  }
}
