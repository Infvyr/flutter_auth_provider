import 'package:flutter/material.dart';
import 'package:flutter_authentication/src/pages/home_page/index.dart';
import 'package:flutter_authentication/src/core/infrastructure/user/user_notifier.dart';
import 'package:flutter_authentication/src/core/presentation/snackbar/app_snackbar.dart';
import 'package:flutter_authentication/src/features/authentication/infrastructure/auth_notifier.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordVisible = false;

  void _onSubmit() {
    // close keyboard if it's open
    FocusScope.of(context).unfocus();

    final email = emailController.text;
    final password = passwordController.text;

    Future.wait([
      Provider.of<AuthNotifier>(context, listen: false).signIn(
        data: {
          "email": email,
          "password": password,
        },
        onSuccess: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );

          AppSnackBar.show(
            context: context,
            type: AppSnackBarType.success,
            message: 'You have successfully signed in!',
          );
        },
        onError: (error) {
          AppSnackBar.show(
            context: context,
            type: AppSnackBarType.error,
            message: error.toString(),
          );
        },
      ),
      Provider.of<UserNotifier>(context, listen: false).getUser(userId: 1),
    ]);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Form(
        // autovalidateMode: AutovalidateMode.always,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              autocorrect: false,
              controller: emailController..text = "eve.holt@reqres.in",
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              controller: passwordController..text = "cityslicka",
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() => passwordVisible = !passwordVisible);
                  },
                  icon: passwordVisible ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                ),
              ),
              // keyboardType: TextInputType.visiblePassword,
              obscureText: !passwordVisible,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: screenSize.width,
              child: FilledButton(
                onPressed: _onSubmit,
                child: const Text('Sign In'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
