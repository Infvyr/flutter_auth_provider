import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/gen/assets.gen.dart';
import 'package:flutter_authentication/src/constants/animations.dart';
import 'package:flutter_authentication/src/features/index.dart';
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
              child: Assets.certificationMin.image(
                width: kPageViewWelcome.imageWidth,
                height: kPageViewWelcome.imageHeight,
              ),
            ),
          ),
          const SizedBox(height: 30),
          const NavigationDots(currentPage: 2),
          AnimatedContainer(
            duration: const Duration(milliseconds: kPageViewDuration + 150),
            margin: EdgeInsets.only(top: headingMarginTop),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: kPageViewDuration + 150),
              opacity: headingMarginTop == 0 ? 1 : 0,
              child: AutoSizeText(
                'Get Certified',
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
                'Start learning and get certified after your training to get a lucrative job.',
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
