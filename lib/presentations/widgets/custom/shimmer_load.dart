import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:themes/themes.dart';

class ShimmerLoad extends StatelessWidget {
  const ShimmerLoad({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);

    return Center(
      child: Shimmer.fromColors(
        baseColor: colors.blue,
        highlightColor: colors.background,
        child: SizedBox(
            height: SpacingUnit.x34,
            child: Lottie.asset(
              Assets.gif.loading,
              height: 50,
              width: 50,
            )),
      ),
    );
  }
}
