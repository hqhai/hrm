import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/log/logger.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/biometric/biometric_cubit.dart';
import 'package:base_app/presentations/bloc/biometric/biometric_state.dart';
import 'package:base_app/presentations/bloc/login/login_bloc.dart';
import 'package:base_app/presentations/bloc/login/login_state.dart';
import 'package:base_app/presentations/pages/login/save_forgot_pass.dart';
import 'package:base_app/presentations/widgets/base_page.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/dialog/biometric/apply_biometric.dart';
import 'package:base_app/presentations/widgets/dialog/biometric/biometric_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/biometric/permission_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/forgot_pass/forgot_pass_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/login/drop_down_menu_language.dart';
import 'package:base_app/presentations/widgets/login/email_and_password.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_show_dialog.dart';

final loginPageRoute = GoRoute(
    path: Pages.login,
    builder: (context, GoRouterState state) => const LoginPage());

//User: minhchien@atlantic.edu.vn          Admin@123

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  String checkEmail = '', checkPassword = '';
  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType> availableBiometrics = [
    BiometricType.fingerprint,
    BiometricType.face
  ];
  bool isCheck = false;
  String notification = '';

  String? dropdownLanguageValue = '';
  String? rememberEmail = '';
  String? rememberPassword = '';
  String? errorEmail = '';
  String? errorPass = '';
  bool checkSaveLogin = false;
  bool isCheckedInput = false;
  bool checkPermission = false;
  bool checkLoadLogin = true;

  @override
  void initState() {
    super.initState();
    emailController.text = "";
    passwordController.text = "";
    _getUsernameSaved();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _getUsernameSaved() async {
    final email = dI<AuthBloc>().state.email;
    if (emailController.text == "") {
      emailController.text = email;
      checkEmail = email;
    }
    final password = dI<AuthBloc>().state.password;
    if (passwordController.text == "") {
      passwordController.text = password;
      checkPassword = password;
    }
  }

  _loginListener(BuildContext context, LoginState state) {
    final appLocalizations = AppLocalizations.of(context)!;
    switch (state.status) {
      case LoginStatus.userLocked:
        lockUpAccount(context: context, email: emailController.text);
        setState(() {
          checkLoadLogin = true;
        });
      case LoginStatus.validateSuccess:
        dI<LoginBloc>().add(RequestLogin(
            username: emailController.text,
            password: passwordController.text,
            saveLogin: checkSaveLogin));
      case LoginStatus.validateFailed:
        setState(() {
          errorEmail = appLocalizations.requiredDataFields;
          errorPass = appLocalizations.requiredDataFields;
        });
      case LoginStatus.loginFailed:
        setState(() {
          errorEmail = appLocalizations.errorEmailOrPassword;
          errorPass = appLocalizations.errorEmailOrPassword;
          checkLoadLogin = true;
        });
      case LoginStatus.notRegisteredForBiometrics:
        notRegisteredForBiometricsDialog(context);
      case LoginStatus.loginSuccess:
      case LoginStatus.statusSuccess:
        passwordController.text = "";
      case LoginStatus.wrongBiometricAccount:
        setState(() {
          biometricsLoginErrorDialog(context);
          checkLoadLogin = true;
        });
      case LoginStatus.statusFalse:
        setState(() {
          errorEmail = appLocalizations.errorEmailOrPassword;
          errorPass = appLocalizations.errorEmailOrPassword;
        });
        ShowDialog.instance
            .showDialogCommon(context, appLocalizations.errorEmailOrPassword);
      case LoginStatus.emailOrUserFalse:
        setState(() {
          errorEmail = appLocalizations.requiredDataFields;
          errorPass = '';
        });
      case LoginStatus.passFalse:
        setState(() {
          errorPass = appLocalizations.requiredDataFields;
          errorEmail = '';
        });
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        _loginListener(context, state);
      },
      child: BasePage(
        body: Stack(
          children: [
            Container(
              color: colors.background,
            ),
            const Center(
              child: SizedBox(
                height: SpacingUnit.x50,
                width: SpacingUnit.x50,
                child: ProgressIndicatorDialog(),
              ),
            ),
            if (checkLoadLogin)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(SpacingUnit.x4),
                  color: colors.background,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topRight,
                        child: LanguageWidget(),
                      ),
                      Image.asset(
                        Assets.images.signIn.logo.path,
                        fit: BoxFit.fill,
                      ),
                      EmailAndPasswordWidget(
                        emailController: emailController,
                        passwordController: passwordController,
                        errorEmail: errorEmail,
                        errorPass: errorPass,
                        onChangeEmail: (value) => onChangeEmail(value),
                        onChangePass: (value) => onChangePassword(value),
                      ),
                      SaveForgotPass(
                        check: checkSaveLogin,
                        callback: () => onClickForgotPassword(),
                        setCheck: (bool? value) => setCheckSaveLogin(value),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: SpacingUnit.x4),
                        child: BlocBuilder<BiometricCubit, BiometricState>(
                          builder: (context, stateBiometric) {
                            return GestureDetector(
                              onTap: () =>
                                  _getBiometric(context, stateBiometric),
                              child: SvgPicture.asset(
                                height: SpacingUnit.x12,
                                width: SpacingUnit.x12,
                                Assets.images.signIn.biometric,
                                colorFilter: ColorFilter.mode(
                                    colors.text.withValues(alpha: 0.5),
                                    BlendMode.srcIn),
                              ),
                            );
                          },
                        ),
                      ),
                      AppButton(
                        title: appLocalizations.login,
                        onSubmit: () => onSubmit(),
                        color: checkInput() ? colors.blue : colors.navy,
                        colorText: checkInput()
                            ? colors.background
                            : colors.background,
                      ),
                      TextButton(
                          child: Text(
                            appLocalizations.quitLoggingInAccessUtilities,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            dI<AuthBloc>().add(const IgnoreLoginEvent());
                          }),
                      // const Expanded(flex: 5, child: SizedBox()),
                      //const ContactHelpWidget(),
                      const Spacer(),
                      Text(
                        appLocalizations
                            .ifYouDoNotHaveAnAccountPleaseContactHCNS,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: SpacingUnit.x4,
                          color: colors.text.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void onClickForgotPassword() {
    dI<AppNavigation>().push(context, page: Pages.forgotPasswordPage);
  }

  void onSubmit() {
    bool isCheck = checkInput();
    if (isCheck) {
      setState(() {
        checkLoadLogin = false;
      });
      Future.delayed(const Duration(seconds: 1), () {
        dI<LoginBloc>().add(ValidateLogin(
            username: emailController.text, password: passwordController.text));
      });
    }
  }

  Future<void> _getBiometric(BuildContext context, BiometricState state) async {
    final appLocalizations = AppLocalizations.of(context)!;
    availableBiometrics = await auth.getAvailableBiometrics();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics && await auth.isDeviceSupported();
    if (!canAuthenticate) {
      setState(() {
        checkPermission = true;
        final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
        showDialog(
          context: currentContext,
          builder: (BuildContext context) {
            return Dialog(
              child: PermissionDialog(
                callBack: () => _setPermission(),
              ),
            );
          },
        );
      });
    } else if (availableBiometrics.isNotEmpty && canAuthenticate) {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: appLocalizations.youPressYourFingerHere,
        options: const AuthenticationOptions(
            useErrorDialogs: true, biometricOnly: true, stickyAuth: true),
      );
      if (didAuthenticate) {
        dI<LoginBloc>().add(BiometricRequestLogin(
            username: state.loginRequest.username,
            password: state.loginRequest.password));
      }
    } else {
      setState(() {
        checkPermission = true;
        final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
        showDialog(
          context: currentContext,
          builder: (BuildContext context) {
            return Dialog(
              child: PermissionDialog(
                callBack: () => _setPermission(),
              ),
            );
          },
        );
      });
      try {} on PlatformException catch (e) {
        logger.w(e.message);
      }
    }
  }

  void onRegister(context) {
    dI<AppNavigation>().push(context, page: Pages.register);
  }

  bool checkInput() {
    final isValid = (checkEmail.isNotEmpty && checkPassword.isNotEmpty);
    return isValid;
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

  setCheckSaveLogin(bool? value) {
    setState(() {
      checkSaveLogin = value!;
    });
  }

  _setPermission() {
    setState(() {
      checkPermission = false;
    });
  }
}
