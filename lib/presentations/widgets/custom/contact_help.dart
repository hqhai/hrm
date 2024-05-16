import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ContactHelpWidget extends StatelessWidget {
  const ContactHelpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        height: SpacingUnit.x16,
        width: SpacingUnit.x60,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: const EdgeInsets.only(bottom: SpacingUnit.x1_5),
                  padding: const EdgeInsets.only(
                      top: SpacingUnit.x3,
                      left: SpacingUnit.x3,
                      bottom: SpacingUnit.x3,
                      right: SpacingUnit.x6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SpacingUnit.x1),
                    border: Border.all(
                      color: colors.text,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    appLocalizations.supportContact,
                    style: TextStyle(fontSize: 16, color: colors.text),
                  )),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  padding: const EdgeInsets.all(SpacingUnit.x2),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(SpacingUnit.x100),
                    border: Border.all(
                      color: colors.text,
                      width: 1,
                    ),
                  ),
                  child: const Icon(Icons.headphones,
                      color: Colors.white, size: 45)),
            ),
          ],
        ),
      ),
    );
  }
}
