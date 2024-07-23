import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/request/login_request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/biometric/biometric_cubit.dart';
import 'package:base_app/presentations/bloc/biometric/biometric_state.dart';
import 'package:base_app/presentations/widgets/base_page.dart';
import 'package:base_app/presentations/widgets/dialog/biometric/biometric_dialog.dart';
import 'package:base_app/presentations/widgets/login/email_and_password.widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_button.dart';

final registerBiometricPageRoute = GoRoute(
    path: Pages.biometricRegister,
    name: Pages.biometricRegister,
    builder: (context, GoRouterState state) => const RegisterBiometricPage());

class RegisterBiometricPage extends StatefulWidget {
  const RegisterBiometricPage({super.key});

  @override
  State<RegisterBiometricPage> createState() => _RegisterBiometricPageState();
}

class _RegisterBiometricPageState extends State<RegisterBiometricPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  String checkEmail = '', checkPassword = '';

  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType> availableBiometrics = [BiometricType.fingerprint];
  bool isCheckedInput = false;

  @override
  void initState() {
    super.initState();
    checkEmail = dI<BiometricCubit>().state.loginRequest.username;
    checkPassword = dI<BiometricCubit>().state.loginRequest.password;
    emailController.text = checkEmail;
    passwordController.text = checkPassword;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BasePage(
      appbar: AppBar(),
      body: Center(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
            border: Border.all(width: 1, color: colors.background),
          ),
          margin: const EdgeInsets.all(SpacingUnit.x2),
          child: Padding(
            padding: const EdgeInsets.all(SpacingUnit.x4),
            child: Column(
              children: [
                const SizedBox(height: SpacingUnit.x4),
                Text(appLocalizations.pleaseEnterYourUsernameAndPasswordHere,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5)),
                EmailAndPasswordWidget(
                  emailController: emailController,
                  passwordController: passwordController,
                  onChangeEmail: (value) => onChangeEmail(value),
                  onChangePass: (value) => onChangePassword(value),
                ),
                AppButton(
                    title: appLocalizations.save,
                    onSubmit: () => onSubmit(),
                    color: checkInput() ? colors.blue : colors.navy,
                    colorText: colors.text),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit() {
    registeredForBiometricsDialog(context, () {
      dI<BiometricCubit>().changeBiometric(
        BiometricState(
            loginRequest: LoginRequest(
              password: passwordController.text,
              username: emailController.text,
            ),
            status: BiometricEnum.haveRegistration),
      );
      Navigator.of(context).pop();
    });
  }

  bool checkInput() {
    RegExp regExpPass = RegExp(checkPasswordRegexExp);
    RegExp regExpEmail = RegExp(checkEmailRegexExp); //
    return (regExpEmail.hasMatch(checkEmail) && regExpPass.hasMatch(checkPassword))
        ? isCheckedInput = true
        : isCheckedInput = false;
  }

  onChangeEmail(String value) {
    setState(() {
      checkEmail = value;
    });
  }

  onChangePassword(String value) {
    setState(() {
      checkPassword = value;
    });
  }
}
