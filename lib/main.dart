import 'package:flutter/material.dart';
import 'package:flutter_authentication/src/core/infrastructure/shared_preferences/shared_prefs_service.dart';
import 'package:flutter_authentication/src/core/infrastructure/user/user_notifier.dart';
import 'package:flutter_authentication/src/core/presentation/styles/app_styles.dart';
import 'package:flutter_authentication/src/features/authentication/infrastructure/auth_notifier.dart';
import 'package:flutter_authentication/src/pages/splash_page/presentation/splash_page.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider, MultiProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthNotifier(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => UserNotifier(),
          lazy: true,
        ),
      ],
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeAnimationCurve: Curves.easeInOut,
          theme: AppStyles.instance.light,
          darkTheme: AppStyles.instance.dark,
          themeMode: ThemeMode.system,
          home: const SplashPage(),
        ),
      ),
    ),
  );
}
