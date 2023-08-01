import 'package:flutter/material.dart';
import 'package:flutter_authentication/src/features/authentication/presentation/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignInForm(),
    );
  }
}
