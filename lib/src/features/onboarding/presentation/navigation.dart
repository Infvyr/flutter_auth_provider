import 'package:flutter/material.dart';
import 'package:flutter_authentication/src/constants/animations.dart';
import 'package:flutter_authentication/src/features/onboarding/infrastructure/onboarding_notifier.dart';
import 'package:provider/provider.dart';

class OnboardingNavigation extends StatefulWidget {
  const OnboardingNavigation({
    super.key,
    required this.currentPage,
    required this.pageController,
    required this.pages,
  });

  final int currentPage;
  final PageController pageController;
  final List<Widget> pages;

  @override
  State<OnboardingNavigation> createState() => _OnboardingNavigationState();
}

class _OnboardingNavigationState extends State<OnboardingNavigation> with SingleTickerProviderStateMixin {
  double kPosition = -30.0;

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
    if (!_onboardingNotifier.navigationAnimationCompleted) {
      _animationController.dispose();
    }
    super.dispose();
  }

  void initAnimation() {
    if (_onboardingNotifier.navigationAnimationCompleted) {
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
      _onboardingNotifier.completeNavigationAnimation = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: kPageViewDuration * 2),
      bottom: kPosition,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: kPageViewDuration * 2),
        opacity: _onboardingNotifier.navigationAnimationCompleted ? 1 : 0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // back button
              if (widget.currentPage != 0)
                TextButton(
                  onPressed: () {
                    widget.pageController.animateToPage(
                      widget.currentPage - 1,
                      duration: const Duration(milliseconds: kPageViewDuration),
                      curve: Curves.easeInOut,
                    );
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(150, 50)),
                  ),
                  child: Text(
                    'Back',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontSize: 16,
                    ),
                  ),
                )
              else
                const SizedBox(),
              // next button
              FilledButton(
                onPressed: () {
                  if (widget.currentPage == widget.pages.length - 1) {
                    // navigate to sign in page
                  } else {
                    widget.pageController.animateToPage(
                      widget.currentPage + 1,
                      duration: const Duration(milliseconds: kPageViewDuration),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(150, 50)),
                ),
                child: Text(
                  widget.currentPage == widget.pages.length - 1 ? 'Get Started' : 'Next',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
