import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:themes/themes.dart';

class CreateRequestSuccess extends StatelessWidget {
  const CreateRequestSuccess({super.key, this.title = ''});

  final String title;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.center,
            title.isNotEmpty ? title : appLocalizations.timekeepingUnSuccess,
            style: TextStyle(
              color: colors.text,
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
        ],
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
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title.isNotEmpty ? title : appLocalizations.timekeepingUnSuccess,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.text,
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
    );
  }

  submit(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }
}

class CreateRequestUnsuccessfulTwoButton extends StatelessWidget {
  final VoidCallback onTapRetry;

  const CreateRequestUnsuccessfulTwoButton({
    super.key,
    this.title = '',
    required this.onTapRetry,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SpacingUnit.x4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(SpacingUnit.x4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2),
              child: Text(
                title.isNotEmpty
                    ? title
                    : appLocalizations.timekeepingUnSuccess,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: SpacingUnit.x5,
                ),
              ),
            ),
            const SizedBox(height: SpacingUnit.x2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x4),
              child: Image.asset(
                Assets.images.signIn.no.path,
                fit: BoxFit.fill,
                height: SpacingUnit.x20,
                width: SpacingUnit.x20,
              ),
            ),
            const SizedBox(height: SpacingUnit.x4),
            Row(
              children: [
                Flexible(
                  child: AppButton(
                    onSubmit: () => submit(context),
                    title: appLocalizations.cancel,
                    colorText: const Color(0xFF808890),
                    color: Colors.transparent,
                    colorBorder: colors.outline,
                  ),
                ),
                const SizedBox(width: SpacingUnit.x4),
                Flexible(
                  child: AppButton(
                    onSubmit: () => onTapRetry.call(),
                    title: appLocalizations.retry,
                    colorText: colors.background,
                    color: const Color(0xFF2F6BFF),
                  ),
                ),
              ],
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

dialogSuccess(
    {required BuildContext context, required String title, bool isPop = true}) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: CreateRequestSuccess(title: title),
      );
    },
  ).then((value) {
    if (context.mounted) {
      if (isPop && dI<AppNavigation>().canPop(context)) {
        _popDialog(context);
      }
    }
  });
}

_popDialog(BuildContext context) {
  dI<AppNavigation>().pop(context);
}

dialogUnsuccessful({required BuildContext context, required String title}) {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;

  showDialog(
    barrierDismissible: false,
    context: currentContext,
    builder: (BuildContext context) {
      return Dialog(
        child: CreateRequestUnsuccessful(
          title: title,
        ),
      );
    },
  );
}

dialogUnsuccessfulTwoButton(
    {required BuildContext context,
    required String title,
    required VoidCallback onTapRetry}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: CreateRequestUnsuccessfulTwoButton(
          title: title,
          onTapRetry: () {
            onTapRetry.call();
            Navigator.pop(context);
          },
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

showToast({required BuildContext context, String errorCode = ''}) {
  final colors = AppTheme.getColors(context);
  dI<AppNavigation>().pop(context);
  Fluttertoast.showToast(
      msg: errorCode,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colors.error,
      textColor: colors.background,
      fontSize: SpacingUnit.x4);
}

completerSuccess({required String requestId, bool isEdit = false}) {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
  final appLocalizations = AppLocalizations.of(currentContext)!;
  if (isEdit) {
    dI<AppNavigation>().popUtil(
      Pages.requisitionListPage,
      buildContext: currentContext,
    );
  } else {
    dI<AppNavigation>().pop(currentContext);
    dI<AppNavigation>().pop(currentContext);
  }
  dialogSuccess(
    context: currentContext,
    title: requestId.isNotEmpty
        ? appLocalizations.editRequestSuccess
        : appLocalizations.createSuccess,
  );
}

approverSuccess({String? title}) {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
  final appLocalizations = AppLocalizations.of(currentContext)!;
  dialogSuccess(
    context: currentContext,
    title: title ?? appLocalizations.approvedSuccess,
  );
}

approverUnsuccessful({required String errorDialog, String? title}) {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
  final appLocalizations = AppLocalizations.of(currentContext)!;
  dialogUnsuccessful(
    context: currentContext,
    title: errorDialog.isNotEmpty
        ? errorDialog
        : title ?? appLocalizations.noConnected,
  );
}

updateProfileFail({
  required String errorDialog,
}) {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
  final appLocalizations = AppLocalizations.of(currentContext)!;
  dI<AppNavigation>().pop(currentContext);
  dialogUnsuccessful(
    context: currentContext,
    title: errorDialog.isNotEmpty
        ? errorDialog
        : appLocalizations.updateUnsuccessful,
  );
}

updateProfileSuccess() {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
  final appLocalizations = AppLocalizations.of(currentContext)!;
  dI<AppNavigation>().pop(currentContext);
  dialogSuccess(
    context: currentContext,
    title: appLocalizations.updateSuccessful,
  );
}

showToastTimeKeeping({required BuildContext context, String errorCode = ''}) {
  final colors = AppTheme.getColors(context);
  Fluttertoast.showToast(
      msg: errorCode,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: colors.tertiary,
      textColor: colors.background,
      fontSize: SpacingUnit.x4);
}
