import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DataNotExist extends StatelessWidget {
  const DataNotExist({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
        margin: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          color: CustomsColor.colorBackground,
          borderRadius: const BorderRadius.all(
            Radius.circular(SpacingUnit.x4),
          ),
        ),
        child: Center(
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
              Expanded(
                child: Image.asset(
                  Assets.images.error.imageDataNoteExist.path,
                  fit: BoxFit.fill,
                  width: kIsWeb? 400 : MediaQuery.of(context).size.width,
                  height: kIsWeb ? 300 : MediaQuery.of(context).size.height * 0.3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
