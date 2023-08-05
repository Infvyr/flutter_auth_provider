import 'package:flutter/material.dart';
import 'package:flutter_authentication/src/core/index.dart';
import 'package:flutter_authentication/src/features/index.dart';
import 'package:flutter_authentication/src/pages/index.dart';
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
          initialRoute: SplashPage.routeName,
          routes: routes,
        ),
      ),
    ),
  );
}
