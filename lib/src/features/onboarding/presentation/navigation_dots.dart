import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_authentication/src/constants/animations.dart';
import 'package:flutter_authentication/src/features/index.dart';

class NavigationDots extends StatefulWidget {
  const NavigationDots({
    super.key,
    required this.currentPage,
  });

  final int currentPage;

  @override
  State<NavigationDots> createState() => _NavigationDotsState();
}

class _NavigationDotsState extends State<NavigationDots> with SingleTickerProviderStateMixin {
  double kPosition = 15.0;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: kPageViewDuration),
  )..forward();
  late final _onboardingNotifier = context.read<OnboardingNotifier>();

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  @override
  void dispose() {
    if (!_onboardingNotifier.dotsAnimationCompleted) {
      _animationController.dispose();
    }
    super.dispose();
  }

  void initAnimation() {
    if (_onboardingNotifier.dotsAnimationCompleted) {
      kPosition = 0.0;
    } else {
      _animationController.addStatusListener(_onAnimationCompleted);
    }
  }

  void _onAnimationCompleted(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        kPosition = 0.0;
      });
      _onboardingNotifier.completeDotsAnimation = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: kPageViewDuration + 50),
      opacity: _onboardingNotifier.dotsAnimationCompleted ? 1 : 0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            kPageViewPages.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: widget.currentPage == index ? 16 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: widget.currentPage == index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
    );
    // );
  }
}
