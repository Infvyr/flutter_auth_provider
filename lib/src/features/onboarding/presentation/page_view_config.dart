import 'package:flutter/widgets.dart' show Widget;

import 'choose.dart';
import 'get_certified.dart';
import 'welcome.dart';

final List<Widget> kPageViewPages = [
  const OnboardingWelcomePage(),
  const OnboardingChoosePage(),
  const OnboardingGetCertifiedPage(),
];
