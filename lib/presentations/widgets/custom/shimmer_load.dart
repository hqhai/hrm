import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:themes/themes.dart';

class ShimmerLoad extends StatelessWidget {
  const ShimmerLoad({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Center(
      child: Shimmer.fromColors(
        baseColor: colors.blue,
        highlightColor: colors.background,
        child: SizedBox(
          height: SpacingUnit.x34,
          child: Text(
            appLocalizations.loading,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: SpacingUnit.x7,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
