import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/log/logger.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/biometric/biometric_cubit.dart';
import 'package:base_app/presentations/bloc/biometric/biometric_state.dart';
import 'package:base_app/presentations/bloc/login/login_bloc.dart';
import 'package:base_app/presentations/bloc/login/login_state.dart';
import 'package:base_app/presentations/widgets/base_page.dart';
import 'package:base_app/presentations/widgets/custom/app_checkbox.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/biometric/biometric_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/biometric/permission_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/password/wrong_password_many.dart';
import 'package:base_app/presentations/widgets/login/email_and_password.widget.dart';
import 'package:base_app/presentations/widgets/login/drop_down_menu_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_button.dart';
import 'package:widgets/app_show_dialog.dart';

final loginPageRoute =
    GoRoute(path: Pages.login, builder: (context, GoRouterState state) => const LoginPage());

//User: huukhoa@atlantic.edu.vn1            Admin@123

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  String checkEmail = '', checkPassword = '';
  late AnimationController _controller;
  late Animation<double> _animationWidth, _animationHeight;
  late double width, height;
  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType> availableBiometrics = [BiometricType.fingerprint, BiometricType.face];
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

  @override
  void initState() {
    super.initState();
    emailController.text = "";
    passwordController.text = "";
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationWidth = const AlwaysStoppedAnimation<double>(0);
    _animationHeight = const AlwaysStoppedAnimation<double>(0);
    _controller.forward();
    _getUsernameSaved();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    _animationWidth = AlwaysStoppedAnimation<double>(width * 0.9);
    _animationHeight = AlwaysStoppedAnimation<double>(height * 0.9);
    _controller.forward();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _controller.dispose();
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
        wrongPasswordManyDialog(context, emailController.text);
        setState(() {
          _animationHeight = AlwaysStoppedAnimation<double>(height * 0.9);
          _animationWidth = AlwaysStoppedAnimation<double>(width * 0.9);
          _controller.forward(from: 0);
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
          _animationHeight = AlwaysStoppedAnimation<double>(height * 0.9);
          _animationWidth = AlwaysStoppedAnimation<double>(width * 0.9);
          _controller.forward(from: 0);
        });
      case LoginStatus.notRegisteredForBiometrics:
        notRegisteredForBiometricsDialog(context);
      case LoginStatus.loginSuccess:
      case LoginStatus.statusSuccess:
        passwordController.text = "";
      case LoginStatus.wrongBiometricAccount:
        setState(() {
          biometricsLoginErrorDialog(context);
          _animationHeight = AlwaysStoppedAnimation<double>(height * 0.9);
          _animationWidth = AlwaysStoppedAnimation<double>(width * 0.9);
          _controller.forward(from: 0);
        });
      case LoginStatus.statusFalse:
        setState(() {
          errorEmail = appLocalizations.errorEmailOrPassword;
          errorPass = appLocalizations.errorEmailOrPassword;
        });
        ShowDialog.instance.showDialogCommon(context, appLocalizations.errorEmailOrPassword);
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
    /* final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;*/
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        _loginListener(context, state);
      },
      child: BasePage(
        body: Stack(
          children: [
            Container(
              color: colors.surface.withOpacity(0.5),
            ),
            const DropdownMenuWidget(),
            Center(
              child: SizedBox(
                height: SpacingUnit.x50,
                width: SpacingUnit.x50,
                child: Lottie.asset(Assets.images.icon.loading,
                    width: SpacingUnit.x50, height: SpacingUnit.x50, fit: BoxFit.fill),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: SizeTransition(
                sizeFactor: _controller,
                child: Center(
                  child: Container(
                    width: _animationWidth.value,
                    height: _animationHeight.value,
                    decoration: BoxDecoration(
                      color: colors.background,
                      borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
                      border: Border.all(width: 1, color: colors.background),
                    ),
                    margin: const EdgeInsets.only(
                        left: SpacingUnit.x8,
                        right: SpacingUnit.x8,
                        bottom: SpacingUnit.x8,
                        top: SpacingUnit.x30),
                    child: Padding(
                      padding: const EdgeInsets.all(SpacingUnit.x4),
                      child: Column(
                        children: [
                          const SizedBox(height: SpacingUnit.x4),
                          Text(appLocalizations.login2,
                              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x6)),
                          Text(appLocalizations.enterYourRegisteredUsernameAndPassword,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4)),
                          EmailAndPasswordWidget(
                            emailController: emailController,
                            passwordController: passwordController,
                            errorEmail: errorEmail,
                            errorPass: errorPass,
                            onChangeEmail: (value) => onChangeEmail(value),
                            onChangePass: (value) => onChangePassword(value),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppCheckbox(
                                  onChanged: (bool? value) => setCheckSaveLogin(value),
                                  label: appLocalizations.staySignedIn,
                                  value: checkSaveLogin,
                                  color: colors.text,
                                  checkColor: Colors.white),
                              GestureDetector(
                                onTap: () => onClickForgotPassword(),
                                child: Text(appLocalizations.forgotPassword,
                                    style: TextStyle(
                                      fontSize: SpacingUnit.x3_5,
                                      color: colors.text,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: SpacingUnit.x4),
                          AppButton(
                            title: appLocalizations.login,
                            onSubmit: () => onSubmit(),
                            color: checkInput() ? colors.blue : colors.navy,
                            colorText: checkInput() ? colors.text : colors.background,
                          ),
                          const SizedBox(height: SpacingUnit.x4),
                          ContainerBorder(
                            backgroundColors: colors.surface.withOpacity(0.5),
                            child: Padding(
                              padding: const EdgeInsets.all(SpacingUnit.x0_5),
                              child: BlocBuilder<BiometricCubit, BiometricState>(
                                builder: (context, stateBiometric) {
                                  return GestureDetector(
                                    onTap: () => _getBiometric(context, stateBiometric),
                                    child: SvgPicture.asset(
                                      height: SpacingUnit.x8,
                                      width: SpacingUnit.x8,
                                      Assets.images.signIn.biometric,
                                      colorFilter:
                                          ColorFilter.mode(colors.background, BlendMode.srcIn),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const Expanded(flex: 5, child: SizedBox()),
                          const SizedBox(height: SpacingUnit.x4),
                          //const ContactHelpWidget(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                appLocalizations.notAMember,
                                style: TextStyle(fontSize: 16, color: colors.text),
                              ),
                              GestureDetector(
                                onTap: () {
                                  onRegister(context);
                                },
                                child: Text(
                                  appLocalizations.signUpNow,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffABBFED),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
        _animationHeight = const AlwaysStoppedAnimation<double>(0);
        _animationWidth = const AlwaysStoppedAnimation<double>(0);
        _controller.forward(from: 0);
      });
      Future.delayed(const Duration(seconds: 1), () {
        dI<LoginBloc>()
            .add(ValidateLogin(username: emailController.text, password: passwordController.text));
      });
    }
  }

  Future<void> _getBiometric(BuildContext context, BiometricState state) async {
    final appLocalizations = AppLocalizations.of(context)!;
    availableBiometrics = await auth.getAvailableBiometrics();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics && await auth.isDeviceSupported();
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
            username: state.loginRequest.username, password: state.loginRequest.password));
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
    RegExp regExpPass = RegExp(checkPasswordRegexExp);
    RegExp regExpEmail = RegExp(checkEmailRegexExp);
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
