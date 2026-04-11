import 'package:base_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Unified loading indicator using the AG logo Lottie animation.
/// Use this everywhere instead of CircularProgressIndicator or raw Lottie calls.
class AppLoadingIndicator extends StatelessWidget {
  final double size;

  const AppLoadingIndicator({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Lottie.asset(
        Assets.gif.loading,
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}
