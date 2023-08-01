import 'package:flutter/material.dart';

enum AppSnackBarType {
  success,
  error,
  warning,
  info,
}

class AppSnackBar {
  static Color _setBackgroundColor(AppSnackBarType type, BuildContext context) {
    switch (type) {
      case AppSnackBarType.success:
        return Theme.of(context).colorScheme.primary;
      case AppSnackBarType.error:
        return Theme.of(context).colorScheme.error;
      case AppSnackBarType.warning:
        return Colors.orange;
      case AppSnackBarType.info:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  static Color _setTextColor(AppSnackBarType type, BuildContext context) {
    switch (type) {
      case AppSnackBarType.success:
        return Theme.of(context).colorScheme.onSecondary;
      case AppSnackBarType.error:
        return Theme.of(context).colorScheme.onError;
      default:
        return Colors.white;
    }
  }

  static void show({
    required BuildContext context,
    required AppSnackBarType type,
    required String message,
  }) {
    final snackBar = ScaffoldMessenger.of(context);

    snackBar
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: _setBackgroundColor(type, context),
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          content: Text(
            message,
            style: TextStyle(
              color: _setTextColor(type, context),
            ),
          ),
        ),
      );
  }
}
