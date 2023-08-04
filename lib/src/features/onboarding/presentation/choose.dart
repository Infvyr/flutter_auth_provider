import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/gen/assets.gen.dart';
import 'package:flutter_authentication/src/constants/animations.dart';
import 'package:flutter_authentication/src/features/onboarding/infrastructure/onboarding_notifier.dart';
import 'package:flutter_authentication/src/features/onboarding/presentation/navigation_dots.dart';
import 'package:provider/provider.dart';

class OnboardingChoosePage extends StatefulWidget {
  const OnboardingChoosePage({super.key});

  @override
  State<OnboardingChoosePage> createState() => _OnboardingChoosePageState();
}

class _OnboardingChoosePageState extends State<OnboardingChoosePage> with SingleTickerProviderStateMixin {
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
    if (!_onboardingNotifier.choosePageAnimationCompleted) {
      _animationController.dispose();
    }
    super.dispose();
  }

  void initAnimation() {
    if (_onboardingNotifier.choosePageAnimationCompleted) {
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
      _onboardingNotifier.completeChoosePageAnimation = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 80),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: kPageViewDuration),
            margin: EdgeInsets.only(top: headingMarginTop),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: kPageViewDuration),
              opacity: headingMarginTop == 0 ? 1 : 0,
              child: Assets.onlineLearningMin.image(
                width: kPageViewWelcome.imageWidth,
                height: kPageViewWelcome.imageHeight,
              ),
            ),
          ),
          const SizedBox(height: 30),
          const NavigationDots(currentPage: 1),
          AnimatedContainer(
            duration: const Duration(milliseconds: kPageViewDuration + 150),
            margin: EdgeInsets.only(top: headingMarginTop),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: kPageViewDuration + 150),
              opacity: headingMarginTop == 0 ? 1 : 0,
              child: AutoSizeText(
                'Choose Your Course',
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
                'Choose the course of your choice and gain industry knowledge and experience in it.',
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
