import 'package:flutter/material.dart';
import 'package:flutter_authentication/gen/assets.gen.dart';

class OnboardingGetCertifiedPage extends StatelessWidget {
  const OnboardingGetCertifiedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Assets.certificationMin.image(),
          const SizedBox(height: 90),
          Text(
            'Get Certified',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            'Start learning and get certified after your training to get a lucrative job',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
