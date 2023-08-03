import 'package:flutter/material.dart';
import 'package:flutter_authentication/gen/assets.gen.dart';
import 'package:flutter_authentication/src/constants/animations.dart';
import 'package:flutter_authentication/src/features/onboarding/infrastructure/onboarding_notifier.dart';
import 'package:provider/provider.dart';

class OnboardingGetCertifiedPage extends StatefulWidget {
  const OnboardingGetCertifiedPage({super.key});

  @override
  State<OnboardingGetCertifiedPage> createState() => _OnboardingGetCertifiedPageState();
}

class _OnboardingGetCertifiedPageState extends State<OnboardingGetCertifiedPage> with SingleTickerProviderStateMixin {
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
    if (!_onboardingNotifier.cerifiedPageAnimationCompleted) {
      _animationController.dispose();
    }
    super.dispose();
  }

  void initAnimation() {
    if (_onboardingNotifier.cerifiedPageAnimationCompleted) {
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
      _onboardingNotifier.completeCertifiedPageAnimation = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const SizedBox(height: 32),
          AnimatedContainer(
            duration: const Duration(milliseconds: kPageViewDuration),
            margin: EdgeInsets.only(top: headingMarginTop),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: kPageViewDuration),
              opacity: headingMarginTop == 0 ? 1 : 0,
              child: Assets.certificationMin.image(
                width: kPageViewWelcome.imageWidth,
                height: kPageViewWelcome.imageHeight,
              ),
            ),
          ),
          const SizedBox(height: 60),
          AnimatedContainer(
            duration: const Duration(milliseconds: kPageViewDuration + 150),
            margin: EdgeInsets.only(top: headingMarginTop),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: kPageViewDuration + 150),
              opacity: headingMarginTop == 0 ? 1 : 0,
              child: Text(
                'Get Certified',
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
              child: Text(
                'Start learning and get certified after your training to get a lucrative job',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
