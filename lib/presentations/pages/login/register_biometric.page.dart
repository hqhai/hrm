import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/request/login_request.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/biometric/biometric_cubit.dart';
import 'package:base_app/presentations/bloc/biometric/biometric_state.dart';
import 'package:base_app/presentations/widgets/custom/app_switch.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/biometric/apply_biometric.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:themes/themes.dart';

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
    isCheckedInput = dI<BiometricCubit>().state.checkBiometric;
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
        centerTitle: true,
        title: Text(
          appLocalizations.settingBiometric,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4_5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Container(
          color: colors.secondaryContainer.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(SpacingUnit.x4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [checkBiometric(context: context)],
            ),
          ),
        ),
      ),
    );
  }

  Widget checkBiometric({
    required BuildContext context,
  }) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return ContainerBorder(
      backgroundColors: colors.background,
      borderColors: colors.background,
      paddingVertical: SpacingUnit.x4,
      paddingHorizontal: SpacingUnit.x4,
      circular: SpacingUnit.x4,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: SpacingUnit.x12,
              width: SpacingUnit.x12,
              child: CircleAvatar(
                backgroundColor: colors.secondaryContainer.withOpacity(0.1),
                child: SvgPicture.asset(
                  height: SpacingUnit.x5,
                  width: SpacingUnit.x5,
                  Assets.images.signIn.biometric,
                  colorFilter: ColorFilter.mode(colors.text.withOpacity(0.5), BlendMode.srcIn),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  appLocalizations.loginBiometricAuthentication,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x3_5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  appLocalizations.useFaceIDInsteadOfAPassword,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x3,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: AppSwitch(
              check: isCheckedInput,
              onChange: (value) => _setCheck(value: value, context: context),
            ),
          )
        ],
      ),
    );
  }

  _setCheck({required bool value, required BuildContext context}) {
    setState(() {
      if (!value) {
        isCheckedInput = !isCheckedInput;
      }
    });
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: !value
              ? ApplyBiometric(
                  check: value,
                  callback: () {
                    dI<BiometricCubit>().changeBiometric(
                      const BiometricState(
                          loginRequest: LoginRequest(
                            password: '',
                            username: '',
                          ),
                          checkBiometric: false,
                          status: BiometricEnum.notRegistered),
                    );
                    dI<AppNavigation>().pop(context);
                  },
                )
              : AuthBiometric(
                  callBack: () => setState(() {
                        isCheckedInput = true;
                      })),
        );
      },
    );
  }
}
