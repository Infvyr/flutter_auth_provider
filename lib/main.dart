import 'package:flutter/material.dart';
import 'package:flutter_authentication/src/core/infrastructure/user/user_notifier.dart';
import 'package:flutter_authentication/src/core/presentation/styles/app_styles.dart';
import 'package:flutter_authentication/src/features/authentication/infrastructure/auth_notifier.dart';
import 'package:flutter_authentication/src/pages/splash_page/presentation/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserNotifier(),
        ),
      ],
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppStyles.instance.light,
          darkTheme: AppStyles.instance.dark,
          themeMode: ThemeMode.system,
          home: const SplashPage(),
        ),
      ),
    ),
  );
}
