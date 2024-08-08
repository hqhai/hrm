import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/app_input_email.dart';
import 'package:base_app/presentations/widgets/dialog/forgot_pass/forgot_pass_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

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

  _listener(String errorCode) {
    setState(() {
      errorEmail = errorResponse()[errorCode];
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) => _listener(state.errorCode),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x15),
                      child: Center(
                        child: Image.asset(
                          Assets.images.signIn.logo.path,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      appLocalizations.email,
                      style: const TextStyle(
                        fontSize: SpacingUnit.x4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                      child: AppInputEmail(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x4),
                      child: AppButton(
                        title: appLocalizations.forgotPassword,
                        onSubmit: () => onSubmit(context),
                        color: checkInput() ? colors.blue : colors.navy,
                        colorText: colors.background,
                      ),
                    ),
                  ],
                ),
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

  void onSubmit(BuildContext context) async {
    bool check = checkInput();
    if (check) {
      final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
      dialogIndicator(context: currentContext);
      Completer completer = Completer<bool>();
      dI<UserBloc>().add(ForgotPasswordEvent(
        email: emailController.text,
        completer: completer,
      ));
      final checkCom = await completer.future;
      if (checkCom) {
        if (!currentContext.mounted) return;
        dI<AppNavigation>().pop(currentContext);
        forgotPassSuccess(context: currentContext, email: checkEmail);
      }
    }
  }

  setCheckEmail(String value) {
    setState(() {
      checkEmail = value;
    });
  }
}
