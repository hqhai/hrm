import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:themes/themes.dart';

class ItemAddStationeryDialog extends StatelessWidget {
  const ItemAddStationeryDialog(
      {super.key, this.unit, this.product, this.unitPrice, this.check = true});

  final String? product, unit;
  final double? unitPrice;
  final bool check;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
          child: Text(
            product ?? "",
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
          child: Text(
            appLocalizations.unit,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
          child: Text(
            unit ?? "",
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4,
            ),
          ),
        ),
        if (check)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
            child: Text(
              appLocalizations.unitPrice,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        if (check)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
            child: Text(
              '${unitPrice ?? 0}',
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
              ),
            ),
          ),
      ],
    );
  }
}
