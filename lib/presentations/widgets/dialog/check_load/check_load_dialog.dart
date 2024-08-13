import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class CreateRequestSuccess extends StatelessWidget {
  const CreateRequestSuccess({super.key, this.title = ''});

  final String title;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpacingUnit.x4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title.isNotEmpty ? title : appLocalizations.timekeepingUnSuccess,
              style: TextStyle(
                color: colors.success,
                fontWeight: FontWeight.w600,
                fontSize: SpacingUnit.x4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x4),
              child: Image.asset(
                Assets.images.signIn.yes.path,
                fit: BoxFit.fill,
                height: SpacingUnit.x20,
                width: SpacingUnit.x20,
              ),
            ),
            AppButton(
              onSubmit: () => submit(context),
              title: appLocalizations.cancel,
              colorText: colors.background,
              color: colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  submit(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }
}

class CreateRequestUnsuccessful extends StatelessWidget {
  const CreateRequestUnsuccessful({super.key, this.title = ''});

  final String title;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpacingUnit.x4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title.isNotEmpty ? title : appLocalizations.timekeepingUnSuccess,
              style: TextStyle(
                color: colors.error,
                fontWeight: FontWeight.w600,
                fontSize: SpacingUnit.x4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x4),
              child: Image.asset(
                Assets.images.signIn.no.path,
                fit: BoxFit.fill,
                height: SpacingUnit.x20,
                width: SpacingUnit.x20,
              ),
            ),
            AppButton(
              onSubmit: () => submit(context),
              title: appLocalizations.cancel,
              colorText: colors.background,
              color: colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  submit(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }
}

dialogSuccess({required BuildContext context, required String title}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SingleChildScrollView(
          child: CreateRequestSuccess(title: title),
        ),
      );
    },
  );
}

dialogUnsuccessful({required BuildContext context, required String title}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SingleChildScrollView(
          child: CreateRequestUnsuccessful(title: title),
        ),
      );
    },
  );
}

setCheckLoad() {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
  dialogIndicator(context: currentContext);
}

completerFail({required String errorDialog, required String requestId}) {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
  final appLocalizations = AppLocalizations.of(currentContext)!;
  dI<AppNavigation>().pop(currentContext);
  dialogUnsuccessful(
    context: currentContext,
    title: errorDialog.isNotEmpty
        ? errorDialog
        : requestId.isNotEmpty
            ? appLocalizations.editRequestUnsuccessful
            : appLocalizations.createRequestFailed,
  );
}

completerSuccess({required String errorDialog, required String requestId}) {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
  final appLocalizations = AppLocalizations.of(currentContext)!;
  dI<AppNavigation>().pop(currentContext);
  dI<AppNavigation>().pop(currentContext);
  dialogSuccess(
    context: currentContext,
    title:
        requestId.isNotEmpty ? appLocalizations.editRequestSuccess : appLocalizations.createSuccess,
  );
}

approverSuccess() {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
  final appLocalizations = AppLocalizations.of(currentContext)!;
  dI<AppNavigation>().pop(currentContext);
  dialogSuccess(
    context: currentContext,
    title: appLocalizations.approvedSuccess,
  );
}

approverUnsuccessful({required String errorDialog}) {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
  final appLocalizations = AppLocalizations.of(currentContext)!;
  dI<AppNavigation>().pop(currentContext);
  dialogUnsuccessful(
    context: currentContext,
    title: errorDialog.isNotEmpty ? errorDialog : appLocalizations.approvedUnsuccessful,
  );
}

updateProfileFail({required String errorDialog}) {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
  final appLocalizations = AppLocalizations.of(currentContext)!;
  dI<AppNavigation>().pop(currentContext);
  dialogUnsuccessful(
    context: currentContext,
    title: errorDialog.isNotEmpty ? errorDialog : appLocalizations.updateUnsuccessful,
  );
}

updateProfileSuccess() {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
  final appLocalizations = AppLocalizations.of(currentContext)!;
  dI<AppNavigation>().pop(currentContext);
  dI<AppNavigation>().pop(currentContext);
  dialogSuccess(
    context: currentContext,
    title: appLocalizations.updateSuccessful,
  );
}
