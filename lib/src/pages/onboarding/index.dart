import 'package:flutter/material.dart';

import 'choose.dart';
import 'get_certified.dart';
import 'navigation.dart';
import 'welcome.dart';

const int transitionDuration = 400;

class OnbordingPage extends StatefulWidget {
  const OnbordingPage({super.key});

  @override
  State<OnbordingPage> createState() => _OnbordingPageState();
}

class _OnbordingPageState extends State<OnbordingPage> {
  final PageController pageController = PageController();

  final List<Widget> pages = [
    const OnboardingWelcomePage(),
    const OnboardingChoosePage(),
    const OnboardingGetCertifiedPage(),
  ];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: () {
                pageController.animateToPage(
                  pages.length - 1,
                  duration: const Duration(milliseconds: transitionDuration),
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
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              itemCount: pages.length,
              itemBuilder: (context, index) => pages[index],
              onPageChanged: (index) {
                setState(() => currentPage = index);
              },
            ),
            OnboardingNavigation(
              currentPage: currentPage,
              pageController: pageController,
              pages: pages,
            ),
          ],
        ),
      ),
    );
  }
}
