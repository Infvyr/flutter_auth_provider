import 'package:flutter/material.dart';
import 'package:flutter_authentication/src/constants/animations.dart';

import 'package:flutter_authentication/src/features/onboarding/presentation/page_view_config.dart';

class NavigationSkipButton extends StatelessWidget {
  const NavigationSkipButton({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: TextButton(
        onPressed: () {
          pageController.animateToPage(
            kPageViewPages.length - 1,
            duration: const Duration(milliseconds: kPageViewDuration),
            curve: Curves.easeInOut,
          );
        },
        child: Text(
          'Skip',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
      ),
    );
  }
}
