import 'package:flutter/material.dart';
import 'package:flutter_authentication/gen/assets.gen.dart';

class LoadingSplashPage extends StatefulWidget {
  const LoadingSplashPage({super.key});

  @override
  State<LoadingSplashPage> createState() => _LoadingSplashPageState();
}

class _LoadingSplashPageState extends State<LoadingSplashPage> {
  double containerWidth = 200;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          containerWidth = 300;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: AnimatedContainer(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 500),
            width: containerWidth,
            child: Assets.logoMin.image(),
          ),
        ),
      ),
    );
  }
}
