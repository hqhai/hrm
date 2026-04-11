import 'package:base_app/presentations/widgets/custom/app_loading_indicator.dart';
import 'package:flutter/material.dart';

class ShimmerLoad extends StatelessWidget {
  const ShimmerLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AppLoadingIndicator(),
    );
  }
}
