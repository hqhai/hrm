import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/widgets/custom/app_input_email.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_dialog_common.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_button.dart';

final forgotPasswordPageRoute = GoRoute(
    path: Pages.forgotPasswordPage,
    builder: (context, GoRouterState state) => const ForgotPasswordPage());

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String? errorEmail = '';
  final TextEditingController emailController = TextEditingController();
  String checkEmail = '';
  bool isCheckedInput = false;

  _listener(BuildContext context, UserState state) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (state.status == UserStatus.init) {
      progressIndicatorDialog(context);
    } else if (state.status == UserStatus.success) {
      Navigator.of(context).pop();
      successFullDialog(context,
          '${appLocalizations.newPasswordHasJustBeenSentToEmail} ${state.email} ${appLocalizations.pleaseCheckYourEmail}');
    } else if (state.status == UserStatus.fail) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  bool checkListenWhen(UserStatus status, UserStatus status2) {
    return status != status2;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) => _listener(context, state),
      listenWhen: (previous, current) => checkListenWhen(
        previous.status,
        current.status,
      ),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: colors.text),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          child: Center(
            child: Container(
              width: width,
              height: height,
              color: colors.background,
              margin: const EdgeInsets.all(SpacingUnit.x2),
              child: Padding(
                padding: const EdgeInsets.all(SpacingUnit.x4),
                child: Column(children: [
                  const SizedBox(height: SpacingUnit.x4),
                  Text(appLocalizations.pleaseEnterTheEmailYouWantToRetrieveYourPassword,
                      style: const TextStyle(fontSize: SpacingUnit.x4)),
                  const SizedBox(height: SpacingUnit.x10_5),
                  AppInputEmail(
                    iconLeft: Padding(
                      padding: const EdgeInsets.all(SpacingUnit.x2_5),
                      child: SvgPicture.asset(
                        Assets.images.icon.person,
                      ),
                    ),
                    placeHolder: appLocalizations.email,
                    autofocus: false,
                    error: errorEmail,
                    controller: emailController,
                    onChange: (value) => setCheckEmail(value),
                  ),
                  const SizedBox(height: SpacingUnit.x8),
                  AppButton(
                    title: appLocalizations.forgotPassword,
                    onSubmit: () => onSubmit(),
                    color: checkInput() ? colors.blue : colors.navy,
                    colorText: checkInput() ? colors.text : colors.background,
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool checkInput() {
    RegExp regExpEmail = RegExp(checkEmailRegexExp);
    return (regExpEmail.hasMatch(checkEmail)) ? isCheckedInput = true : isCheckedInput = false;
  }

  void onSubmit() {
    bool check = checkInput();
    if (check) {
      dI<UserBloc>().add(ForgotPasswordEvent(email: emailController.text));
    }
  }

  setCheckEmail(String value) {
    setState(() {
      checkEmail = value;
    });
  }
}
