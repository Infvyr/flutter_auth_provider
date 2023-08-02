import 'package:flutter/material.dart';
import 'package:flutter_authentication/src/features/onboarding/presentation/index.dart';
import 'package:flutter_authentication/src/pages/home_page/home_page.dart';
import 'package:flutter_authentication/src/features/authentication/infrastructure/auth_notifier.dart';
import 'package:flutter_authentication/src/pages/splash_page/presentation/loading_splash_page.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);

    Future<void> initializeApp(AuthNotifier authNotifier) async {
      await Future.delayed(const Duration(seconds: 3));
      await authNotifier.checkToken();
    }

    return FutureBuilder<void>(
      future: initializeApp(authNotifier),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (authNotifier.token.isNotEmpty) {
            // User is authenticated, navigate to home page
            return const HomePage();
          } else {
            // User is not authenticated, navigate to onboarding page
            return const OnbordingPage();
          }
        } else {
          // Show a loading splash page during the token check
          return const LoadingSplashPage();
        }
      },
    );
  }
}
