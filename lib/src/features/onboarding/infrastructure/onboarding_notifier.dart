import 'package:flutter/foundation.dart' show ChangeNotifier;

class OnboardingNotifier extends ChangeNotifier {
  bool welcomePageAnimationCompleted = false;
  bool choosePageAnimationCompleted = false;
  bool cerifiedPageAnimationCompleted = false;
  bool dotsAnimationCompleted = false;
  bool navigationAnimationCompleted = false;

  set completeWelcomePageAnimation(bool value) {
    welcomePageAnimationCompleted = value;
    notifyListeners();
  }

  set completeChoosePageAnimation(bool value) {
    choosePageAnimationCompleted = value;
    notifyListeners();
  }

  set completeCertifiedPageAnimation(bool value) {
    cerifiedPageAnimationCompleted = value;
    notifyListeners();
  }

  set completeDotsAnimation(bool value) {
    dotsAnimationCompleted = value;
    notifyListeners();
  }

  set completeNavigationAnimation(bool value) {
    navigationAnimationCompleted = value;
    notifyListeners();
  }
}
