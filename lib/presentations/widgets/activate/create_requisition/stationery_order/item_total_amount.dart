import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemTotalAmount extends StatelessWidget {
  const ItemTotalAmount({super.key, required this.totalAmount});
  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appLocalizations.paymentAfterTax,
          style: TextStyle(
            fontSize: SpacingUnit.x3_5,
            color: colors.text,
          ),
        ),
        Text(
          '${totalAmount.toInt().toString()} VND',
          style: TextStyle(
            fontSize: SpacingUnit.x3_5,
            color: colors.text,
          ),
        ),
      ],
    );
  }
}
