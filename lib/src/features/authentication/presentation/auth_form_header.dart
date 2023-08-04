import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AuthFormHeader extends StatelessWidget {
  const AuthFormHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          child: const FlutterLogo(size: 38),
        ),
        if (title.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: AutoSizeText(
              title,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 20,
                  ),
            ),
          ),
        ]
      ],
    );
  }
}
