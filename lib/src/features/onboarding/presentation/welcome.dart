import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_authentication/gen/assets.gen.dart';
import 'package:flutter_authentication/src/constants/animations.dart';
import 'package:flutter_authentication/src/features/onboarding/infrastructure/onboarding_notifier.dart';
import 'package:flutter_authentication/src/features/onboarding/presentation/navigation_dots.dart';

class OnboardingWelcomePage extends StatefulWidget {
  const OnboardingWelcomePage({super.key});

  @override
  State<OnboardingWelcomePage> createState() => _OnboardingWelcomePageState();
}

class _OnboardingWelcomePageState extends State<OnboardingWelcomePage> with SingleTickerProviderStateMixin {
  double headingMarginTop = 15;
  double textMarginTop = 15;

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
    if (!_onboardingNotifier.welcomePageAnimationCompleted) {
      _animationController.dispose();
    }
    super.dispose();
  }

  void initAnimation() {
    if (_onboardingNotifier.welcomePageAnimationCompleted) {
      headingMarginTop = 0;
      textMarginTop = 0;
    } else {
      _animationController.addStatusListener(_onAnimationCompleted);
    }
  }

  void _onAnimationCompleted(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        headingMarginTop = 0;
      });
      Future.delayed(const Duration(milliseconds: kPageViewDuration), () {
        if (mounted) {
          setState(() {
            textMarginTop = 0;
          });
        }
      });
      _onboardingNotifier.completeWelcomePageAnimation = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        children: [
          const SizedBox(height: 32),
          AnimatedContainer(
            duration: const Duration(milliseconds: kPageViewDuration),
            margin: EdgeInsets.only(top: headingMarginTop),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: kPageViewDuration),
              opacity: headingMarginTop == 0 ? 1 : 0,
              child: Assets.educatorMin.image(
                width: kPageViewWelcome.imageWidth,
                height: kPageViewWelcome.imageHeight,
              ),
            ),
          ),
          const SizedBox(height: 30),
          const NavigationDots(currentPage: 0),
          AnimatedContainer(
            duration: const Duration(milliseconds: kPageViewDuration + 150),
            margin: EdgeInsets.only(top: headingMarginTop),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: kPageViewDuration + 150),
              opacity: headingMarginTop == 0 ? 1 : 0,
              child: AutoSizeText(
                'Welcome to Flutter Auth',
                textAlign: TextAlign.center,
                minFontSize: 20,
                maxFontSize: 32,
                maxLines: 1,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          const SizedBox(height: 16),
          AnimatedContainer(
            duration: const Duration(milliseconds: kPageViewDuration + 250),
            margin: EdgeInsets.only(top: headingMarginTop),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: kPageViewDuration + 250),
              opacity: textMarginTop == 0 ? 1 : 0,
              child: AutoSizeText(
                'Welcome as you learn a world changing skill to get a better job.',
                textAlign: TextAlign.center,
                minFontSize: 16,
                maxFontSize: 18,
                maxLines: 4,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
