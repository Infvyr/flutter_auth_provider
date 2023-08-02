import 'package:flutter/material.dart';

const int transitionDuration = 400;

class OnboardingNavigation extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // back button
            if (currentPage != 0)
              TextButton(
                onPressed: () {
                  pageController.animateToPage(
                    currentPage - 1,
                    duration: const Duration(milliseconds: transitionDuration),
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
                if (currentPage == pages.length - 1) {
                  // navigate to sign in page
                } else {
                  pageController.animateToPage(
                    currentPage + 1,
                    duration: const Duration(milliseconds: transitionDuration),
                    curve: Curves.easeInOut,
                  );
                }
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(150, 50)),
              ),
              child: Text(
                currentPage == pages.length - 1 ? 'Get Started' : 'Next',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
