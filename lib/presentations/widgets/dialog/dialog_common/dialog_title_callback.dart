import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/activate/requisition/button_request.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class TitleCallbackDialog extends StatelessWidget {
  const TitleCallbackDialog({
    super.key,
    required this.callback,
    required this.title,
  });

  final String title;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return ContainerBorder(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x5,
            ),
          ),
          ButtonRequest(
            title1: appLocalizations.apply,
            title2: appLocalizations.cancel,
            apply: () => setApply(context),
            reject: () => setReject(context),
          )
        ],
      ),
    );
  }

  setApply(BuildContext context) {
    callback.call();
  }

  setReject(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }


}
