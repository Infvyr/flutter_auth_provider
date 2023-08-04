import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthFormFooter extends StatelessWidget {
  const AuthFormFooter({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  });

  final String title;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: title,
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                const TextSpan(
                  text: ' ',
                ),
                TextSpan(
                  text: buttonText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  recognizer: TapGestureRecognizer()..onTap = onPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
