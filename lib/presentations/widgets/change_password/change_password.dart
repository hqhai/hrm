import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/login/login_bloc.dart';
import 'package:base_app/presentations/bloc/login/login_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/app_input_password.dart';
import 'package:base_app/presentations/widgets/dialog/password/change_password_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
import 'package:base_app/presentations/widgets/register/app_input_new_pssword_validate.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final changePasswordPageRoute = GoRoute(
    path: Pages.changePasswordPage,
    builder: (context, GoRouterState state) => const ChangePassword());

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String notification1 = '', notification2 = '';

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(SpacingUnit.x8),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text(appLocalizations.changePassword,
                      style: const TextStyle(fontSize: SpacingUnit.x5)),
                  const SizedBox(
                    height: 15,
                  ),
                  AppInputPassword(
                    error: notification1,
                    placeHolder: appLocalizations.currentPassword,
                    controller: currentPasswordController,
                    onChange: (value) => {
                      setState(() {
                        currentPasswordController.text = value;
                      }),
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppInputPassword(
                    placeHolder: appLocalizations.newPassword,
                    controller: newPasswordController,
                    onChange: (value) {
                      setState(() {
                        newPasswordController.text = value;
                        progress();
                      });
                    },
                  ),
                  const SizedBox(
                    height: SpacingUnit.x3_75,
                  ),
                  AppInputPassword(
                    error: notification2,
                    placeHolder: appLocalizations.confirmPassword,
                    controller: confirmPasswordController,
                    onChange: (value) => {
                      setState(() {
                        confirmPasswordController.text = value;
                      })
                    },
                  ),
                  const SizedBox(
                    height: SpacingUnit.x3_75,
                  ),
                  if (newPasswordController.text != '')
                    AppInputNewPasswordValidate(
                        password: newPasswordController.text, condition: condition),
                  const SizedBox(
                    height: SpacingUnit.x3_75,
                  ),
                  AppButton(
                      onSubmit: () => onSubmit(state),
                      colorText: colors.background,
                      title: appLocalizations.changePassword,
                      color: !_checkPass() ? colors.outline.withOpacity(0.4) : colors.navy),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  int condition = 0, condition_1 = 0, condition_2 = 0, condition_3 = 0, condition_4 = 0;

  void progress() {
    RegExp(r'^.{9,}$').hasMatch(newPasswordController.text) ? condition_1 = 1 : condition_1 = 0;
    RegExp(r'.*[0-9]+.*').hasMatch(newPasswordController.text) ? condition_2 = 1 : condition_2 = 0;
    RegExp(r'.*[A-Z]+.*').hasMatch(newPasswordController.text) ? condition_3 = 1 : condition_3 = 0;
    RegExp(r'.*[\W_]+.*').hasMatch(newPasswordController.text) ? condition_4 = 1 : condition_4 = 0;
    condition = condition_1 + condition_2 + condition_3 + condition_4;
  }

  bool _checkPass() {
    RegExp regExpPass = RegExp(checkPasswordRegexExp);
    return confirmPasswordController.text != '' &&
        newPasswordController.text != '' &&
        regExpPass.hasMatch(newPasswordController.text);
  }

  _notificationOrDialog(UserState state, BuildContext context) async {
    final appLocalizations = AppLocalizations.of(context)!;
    if (newPasswordController.text != confirmPasswordController.text &&
        confirmPasswordController.text != '') {
      setState(() {
        notification2 = appLocalizations.newPasswordOtherConfirmPassword;
      });
    } else {
      changePasswordDialog(
        context: context,
        callback: () async {
          final Completer completer = Completer<bool>();
          dI<UserBloc>().add(
            ChangePasswordEvent(
              newPassword: newPasswordController.text,
              currentPassword: currentPasswordController.text,
              completer: completer,
            ),
          );
          final check = await completer.future;
          final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
          if (check) {
            if (!currentContext.mounted) return;
            successDialog(currentContext);
            setState(() {
              notification1 = '';
            });
            currentPasswordController.text = '';
            newPasswordController.text = '';
            confirmPasswordController.text = '';
            if (dI<LoginBloc>().state.status == LoginStatus.firstLoginSuccess) {
              dI<LoginBloc>().add(const ChangePasswordSuccessEvent());
            }
          } else {
            if (!currentContext.mounted) return;
            unsuccessfulDialog(currentContext);
            setState(() {
              notification1 = appLocalizations.currentPasswordIsIncorrect;
            });
          }
        },
      );
    }
  }

  onSubmit(UserState state) {
    if (_checkPass()) {
      _notificationOrDialog(state, context);
    }
  }
}
