import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ItemButtonReadMoreOvertime extends StatelessWidget {
  const ItemButtonReadMoreOvertime({super.key, required this.onShowDialog});
  final VoidCallback onShowDialog;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        InkWell(
          onTap: onShowDialog,
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF0FF),
                    borderRadius: BorderRadius.circular(SpacingUnit.x6),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Color(0xFF2F6BFF),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  appLocalizations.i18nReadMore,
                  style: const TextStyle(
                    color: Color(0xFF2F6BFF),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
