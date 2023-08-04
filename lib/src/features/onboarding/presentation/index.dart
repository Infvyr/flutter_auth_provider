import 'package:flutter/material.dart';
import 'package:flutter_authentication/src/features/onboarding/infrastructure/onboarding_notifier.dart';
import 'package:provider/provider.dart';

import 'navigation.dart';
import 'navigation_skip_button.dart';
import 'page_view_config.dart';

class OnbordingPage extends StatefulWidget {
  const OnbordingPage({super.key});

  @override
  State<OnbordingPage> createState() => _OnbordingPageState();
}

class _OnbordingPageState extends State<OnbordingPage> {
  PageController pageController = PageController();

  int currentPage = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isVisibleSkipWidget = currentPage != kPageViewPages.length - 1;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          isVisibleSkipWidget ? NavigationSkipButton(pageController: pageController) : const SizedBox(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: ChangeNotifierProvider(
          create: (_) => OnboardingNotifier(),
          lazy: true,
          child: Stack(
            children: [
              PageView.builder(
                controller: pageController,
                itemCount: kPageViewPages.length,
                itemBuilder: (_, index) => kPageViewPages[index],
                onPageChanged: (index) {
                  setState(() => currentPage = index);
                },
              ),
              OnboardingNavigation(
                currentPage: currentPage,
                pageController: pageController,
                pages: kPageViewPages,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
