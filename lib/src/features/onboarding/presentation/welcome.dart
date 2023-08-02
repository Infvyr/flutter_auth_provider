import 'package:flutter/material.dart';
import 'package:flutter_authentication/gen/assets.gen.dart';
import 'package:flutter_authentication/src/constants/animations.dart';

class OnboardingWelcomePage extends StatefulWidget {
  const OnboardingWelcomePage({super.key});

  @override
  State<OnboardingWelcomePage> createState() => _OnboardingWelcomePageState();
}

class _OnboardingWelcomePageState extends State<OnboardingWelcomePage> with SingleTickerProviderStateMixin {
  double headingMarginTop = 15;
  double textMarginTop = 15;
  bool isHeadingAnimationCompleted = false;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: kPageViewDuration),
  )..forward();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isHeadingAnimationCompleted) {
        _animationController.addStatusListener(_onAnimationCompleted);
      }
    });
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_onAnimationCompleted);
    _animationController.dispose();
    super.dispose();
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
      isHeadingAnimationCompleted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const SizedBox(height: 32),
          SizedBox(
            width: kPageViewWelcome.imageWidth,
            height: kPageViewWelcome.imageHeight,
            child: Assets.educatorMin.image(
              frameBuilder: (_, child, frame, __) {
                return Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      top: frame == null ? 60 : 0,
                      width: kPageViewWelcome.imageWidthScaled,
                      child: child,
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 60),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            margin: EdgeInsets.only(top: headingMarginTop),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: headingMarginTop == 0 ? 1 : 0,
              child: Text(
                'Welcome to Flutter Auth',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          const SizedBox(height: 16),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            margin: EdgeInsets.only(top: headingMarginTop),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: textMarginTop == 0 ? 1 : 0,
              child: Text(
                'Welcome as you learn a world changing skill to get a better job.',
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
