import 'package:flutter/material.dart';
import 'package:flutter_authentication/gen/assets.gen.dart';

class LoadingSplashPage extends StatelessWidget {
  const LoadingSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.all(32.0),
        width: double.infinity,
        child: Center(
          child: Assets.logoMin.image(),
        ),
      ),
    );
  }
}
