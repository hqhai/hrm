import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/request/login_request.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/biometric/biometric_cubit.dart';
import 'package:base_app/presentations/bloc/biometric/biometric_state.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/app_input_password.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ApplyBiometric extends StatelessWidget {
  const ApplyBiometric({super.key, required this.check, required this.callback});

  final bool check;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            check
                ? appLocalizations.settingBiometricSuccessful
                : appLocalizations.cancelBiometricSuccessful,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x5,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x8),
            child: Center(
              child: Image.asset(
                Assets.images.signIn.yes.path,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(SpacingUnit.x2),
            child: AppButton(
              title: appLocalizations.continues,
              onSubmit: () => callback.call(),
            ),
          )
        ],
      ),
    );
  }
}

class AuthBiometric extends StatefulWidget {
  const AuthBiometric({super.key, required this.callBack});

  final VoidCallback callBack;

  @override
  State<AuthBiometric> createState() => _AuthBiometricState();
}

class _AuthBiometricState extends State<AuthBiometric> {
  final TextEditingController passwordController = TextEditingController();
  String email = '', password = '';

  @override
  void initState() {
    email = dI<AuthBloc>().state.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: SpacingUnit.x4),
          Text(
            appLocalizations.authAccount,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x5,
              fontWeight: FontWeight.w600,
            ),
          ),
          ContainerBorder(
            width: width,
            paddingVertical: SpacingUnit.x4,
            borderColors: colors.outline.withOpacity(0.5),
            child: Text(
              email,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
              ),
            ),
          ),
          const SizedBox(height: SpacingUnit.x4),
          Padding(
            padding: const EdgeInsets.only(
              bottom: SpacingUnit.x2,
              top: SpacingUnit.x2,
            ),
            child: AppInputPassword(
              placeHolder: appLocalizations.password,
              controller: passwordController,
              onChange: (value) => onChangePassword(value),
            ),
          ),
          const SizedBox(height: SpacingUnit.x4),
          AppButton(
              title: appLocalizations.continues,
              onSubmit: () => onSubmit(context),
              color: checkInput() ? colors.blue : colors.navy,
              colorText: colors.background),
        ],
      ),
    );
  }

  void onSubmit(BuildContext context) {
    if (checkInput()) {
      dI<AppNavigation>().pop(context);
      dI<BiometricCubit>().changeBiometric(
        BiometricState(
            loginRequest: LoginRequest(
              password: passwordController.text,
              username: email,
            ),
            status: BiometricEnum.haveRegistration),
      );
      widget.callBack.call();
      showDialogSuccess(context);
    }
  }

  bool checkInput() {
    RegExp regExpPass = RegExp(checkPasswordRegexExp);
    RegExp regExpEmail = RegExp(checkEmailRegexExp); //
    return (regExpEmail.hasMatch(email) && regExpPass.hasMatch(password));
  }

  onChangeEmail(String value) {
    setState(() {
      email = value;
    });
  }

  showDialogSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ApplyBiometric(
            check: true,
            callback: () {
              dI<AppNavigation>().pop(context);
            },
          ),
        );
      },
    );
  }

  onChangePassword(String value) {
    setState(() {
      password = value;
    });
  }
}

notRegisteredForBiometricsDialog(BuildContext context) async {

  return showDialog(
    context: context,
    builder: (context) {
      return const Dialog(
        child: NotRegister(),
      );
    },
  );
}

class NotRegister extends StatelessWidget {
  const NotRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            appLocalizations.notRegisteredForBiometrics,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x5,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x8),
            child: SizedBox(
              height: SpacingUnit.x25,
              width: SpacingUnit.x25,
              child: CircleAvatar(
                backgroundColor: colors.secondaryContainer.withOpacity(0.1),
                child: SvgPicture.asset(
                  height: SpacingUnit.x13,
                  width: SpacingUnit.x13,
                  Assets.images.signIn.biometric,
                  colorFilter: ColorFilter.mode(colors.text.withOpacity(0.5), BlendMode.srcIn),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(SpacingUnit.x2),
            child: AppButton(
              title: appLocalizations.ok,
              onSubmit: () => dI<AppNavigation>().pop(context),
            ),
          )
        ],
      ),
    );
  }
}

