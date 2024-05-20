import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/login/login_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/widgets/custom/app_input_email.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/success_dialog_common.dart';
import 'package:base_app/presentations/widgets/dialog/success_or_unsuccess_dialog.dart';
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
    if (state.status == UserStatus.forgotPasswordInit) {
      progressIndicatorDialog(context);
    } else if (state.status == UserStatus.forgotPasswordSuccess) {
      Navigator.of(context).pop();
      successFullDialog(context,
          '${appLocalizations.newPasswordHasJustBeenSentToEmail} ${emailController.text} ${appLocalizations.pleaseCheckYourEmail}');
    } else if (state.status == UserStatus.forgotPasswordError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) => _listener(context, state),
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          alignment: Alignment.topCenter,
          child: Center(
            child: Container(
              width: width,
              height: height,
              color: CustomsColor.colorBackground,
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
                    color: checkInput()
                        ? CustomsColor.colorButtonSelect
                        : CustomsColor.colorUnButtonSelect,
                    colorText: checkInput() ? colors.text : CustomsColor.colorTextUnButtonSelect,
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
    RegExp regExpEmail = RegExp(checkEmailRegexExpTest);
    return (regExpEmail.hasMatch(checkEmail)) ? isCheckedInput = true : isCheckedInput = false;
  }

  void onSubmit() {
    bool check = checkInput();
    if(check){
      dI<UserBloc>().add(ForgotPasswordEvent(email: emailController.text));

    }
  }

  setCheckEmail(String value) {
    setState(() {
      checkEmail = value;
    });
  }
}
