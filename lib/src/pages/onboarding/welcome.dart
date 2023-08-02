import 'package:flutter/material.dart';
import 'package:flutter_authentication/gen/assets.gen.dart';

class OnboardingWelcomePage extends StatelessWidget {
  const OnboardingWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Assets.educatorMin.image(),
          const SizedBox(height: 90),
          Text(
            'Welcome to Flutter Auth',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            'Welcome as you learn a world changing skill to get a better job.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
