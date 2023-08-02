import 'package:flutter/material.dart';
import 'package:flutter_authentication/gen/assets.gen.dart';

class OnboardingChoosePage extends StatelessWidget {
  const OnboardingChoosePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Assets.onlineLearningMin.image(),
          const SizedBox(height: 90),
          Text(
            'Choose Your Course',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            'Choose the course of your choice and gain industry knowledge and experience in it.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
