import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class DataNotExist extends StatelessWidget {
  const DataNotExist({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            appLocalizations.oops,
            style: TextStyle(
                color: colors.text, fontSize: SpacingUnit.x11, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: SpacingUnit.x1,
          ),
          Text(
            appLocalizations.noDataFound,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4_5,
            ),
          ),
          const SizedBox(
            height: SpacingUnit.x9,
          ),
          Image.asset(
            Assets.images.error.imageDataNoteExist.path,
            fit: BoxFit.fill,
            width: SpacingUnit.x40,
            height: SpacingUnit.x40,
          )
        ],
      ),
    );
  }
}
