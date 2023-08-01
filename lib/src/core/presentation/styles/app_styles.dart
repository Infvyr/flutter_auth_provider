import 'package:flutter/material.dart';

@immutable
class AppStyles extends ThemeExtension<AppStyles> {
  const AppStyles({
    this.brandColor = const Color(0xFF66328E),
    this.textColor = const Color(0xFF2B2B2B),
  });

  final Color? brandColor;
  final Color? textColor;

  static get instance => const AppStyles();

  // static const Color primaryColor = ;
  // static const Color secondaryColor = ;

  @override
  AppStyles copyWith({Color? brandColor, Color? textColor}) {
    return AppStyles(
      brandColor: brandColor ?? this.brandColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  ThemeExtension<AppStyles> lerp(covariant ThemeExtension<AppStyles>? other, double t) {
    if (other is! AppStyles) {
      return this;
    }
    return AppStyles(
      brandColor: Color.lerp(brandColor, other.brandColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
    );
  }

  ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        background: const Color.fromARGB(255, 253, 249, 249),
        primary: brandColor,
        surface: Colors.white,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(88, 50)),
          textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AppStyles.instance.brandColor,
          ),
        ),
        labelStyle: TextStyle(
          color: AppStyles.instance.brandColor,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 210, 208, 208),
        ),
        suffixIconColor: AppStyles.instance.brandColor,
      ),
      listTileTheme: ListTileThemeData(
        textColor: AppStyles.instance.textColor,
        iconColor: AppStyles.instance.textColor,
      ),
      drawerTheme: const DrawerThemeData(
        elevation: 0,
      ),
      splashFactory: InkRipple.splashFactory,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        linearTrackColor: Color(0xFFE0E0E0),
        linearMinHeight: 4,
      ),
      extensions: const [
        AppStyles(),
      ],
    );
  }

  ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        background: const Color(0xFF2D2D2D),
        primary: brandColor,
        surface: const Color(0xFF252525),
        onSurface: Colors.white,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(88, 50)),
          textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16)),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: TextStyle(
          color: Color.fromARGB(255, 210, 208, 208),
        ),
        suffixIconColor: Colors.white,
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: Colors.white,
      ),
      drawerTheme: const DrawerThemeData(
        elevation: 0,
      ),
      splashFactory: InkRipple.splashFactory,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        linearTrackColor: Color(0xFFE0E0E0),
        linearMinHeight: 4,
      ),
      extensions: const [
        AppStyles(),
      ],
    );
  }
}
