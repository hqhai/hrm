import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/login/login_bloc.dart';
import 'package:base_app/presentations/bloc/login/login_state.dart';
import 'package:base_app/presentations/bloc/themes/language_cubit.dart';
import 'package:base_app/presentations/widgets/base_page.dart';
import 'package:base_app/presentations/widgets/custom/app_checkbox.dart';
import 'package:base_app/presentations/widgets/custom/app_input_email.dart';
import 'package:base_app/presentations/widgets/custom/app_input_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_button.dart';
import 'package:widgets/app_show_dialog.dart';

final loginPageRoute = GoRoute(
    path: Pages.login,
    builder: (context, GoRouterState state) => const LoginPage());

//User: huukhoa@atlantic.edu.vn1            Admin@123

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String checkEmail = '', checkPassword = '';
  late AnimationController _controller;
  late Animation<double> _animationWidth, _animationHeight;
  late double width, height;

  String? rememberEmail = '';
  String? rememberPassword = '';
  String? errorEmail = '';
  String? errorPass = '';
  bool checkSaveLogin = false;
  bool isCheckedInput = false;

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
      case LoginStatus.validateSuccess:
        dI<LoginBloc>().add(RequestLogin(
            username: emailController.text,
            password: passwordController.text,
            saveLogin: checkSaveLogin));
      case LoginStatus.validateFailed:
        setState(() {
          errorEmail = 'Required data field';
          errorPass = 'Required data field';
        });
      case LoginStatus.loginFailed:
        setState(() {
          errorEmail = appLocalizations.errorEmailOrPassword;
          errorPass = appLocalizations.errorEmailOrPassword;
          _animationHeight = AlwaysStoppedAnimation<double>(height * 0.9);
          _animationWidth = AlwaysStoppedAnimation<double>(width * 0.9);
          _controller.forward(from: 0);
        });
      case LoginStatus.loginSuccess:
      case LoginStatus.statusSuccess:
        passwordController.text = "";
      case LoginStatus.statusFalse:
        setState(() {
          errorEmail = appLocalizations.errorEmailOrPassword;
          errorPass = appLocalizations.errorEmailOrPassword;
        });
        ShowDialog.instance
            .showDialogCommon(context, 'Error email or password');
      case LoginStatus.emailOrUserFalse:
        setState(() {
          errorEmail = 'Required data field';
          errorPass = '';
        });
      case LoginStatus.passFalse:
        setState(() {
          errorPass = 'Required data field';
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        _loginListener(context, state);
      },
      child: BasePage(
        body: Stack(
          children: [
            Image.asset(
              Assets.images.signIn.background.path,
              fit: BoxFit.fill,
              width: width,
              height: height,
            ),
            Center(
              child: SizedBox(
                height: SpacingUnit.x50,
                width: SpacingUnit.x50,
                child: Lottie.asset(
                  Assets.images.icon.loading,
                  width: SpacingUnit.x50,
                  height: SpacingUnit.x50,
                  fit: BoxFit.fill,
                ),
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
                      color: CustomsColor.colorBackground,
                      borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
                      border: Border.all(
                        width: 1,
                        color: CustomsColor.colorBackground,
                      ),
                    ),
                    margin: const EdgeInsets.all(SpacingUnit.x8),
                    child: Padding(
                      padding: const EdgeInsets.all(SpacingUnit.x4),
                      child: Column(children: [
                        const SizedBox(height: SpacingUnit.x4),
                        Image.asset(Assets.images.signIn.logo.path,
                            fit: BoxFit.fill,
                            width: width,
                            height: height * 0.15),
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
                          onChange: (value) => setState(() {
                            checkEmail = value;
                          }),
                        ),
                        const SizedBox(height: SpacingUnit.x4),
                        AppInputPassword(
                          iconLeft: Padding(
                            padding: const EdgeInsets.all(SpacingUnit.x2_5),
                            child: SvgPicture.asset(
                              Assets.images.icon.lock,
                            ),
                          ),
                          error: errorPass,
                          autofocus: false,
                          placeHolder: appLocalizations.password,
                          controller: passwordController,
                          onChange: (value) => setState(() {
                            checkPassword = value;
                          }),
                        ),
                        const SizedBox(height: SpacingUnit.x4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppCheckbox(
                                onChanged: (bool? value) => setState(() {
                                      checkSaveLogin = value!;
                                    }),
                                label: appLocalizations.staySignedIn,
                                value: checkSaveLogin,
                                color: CustomsColor.colorText,
                                checkColor: Colors.white),
                            GestureDetector(
                              onTap: () => onClickForgotPassword(),
                              child: Text(appLocalizations.forgotPassword,
                                  style: TextStyle(
                                    fontSize: SpacingUnit.x3_5,
                                    color: CustomsColor.colorText,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(height: SpacingUnit.x4),
                        AppButton(
                          title: appLocalizations.login,
                          onSubmit: () => {
                            if (checkInput()) onSubmit(),
                          },
                          color: checkInput()
                              ? CustomsColor.colorButtonSelect
                              : CustomsColor.colorUnButtonSelect,
                          colorText: checkInput()
                              ? colors.text
                              : CustomsColor.colorTextUnButtonSelect,
                        ),
                        const Expanded(
                          flex: 5,
                          child: SizedBox(),
                        ),
                        BlocBuilder<LanguageCubit, String>(
                          builder: (context, languageCode) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(SpacingUnit.x2_5),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () => _language(languageCode),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.all(SpacingUnit.x2_5),
                                  child: Text(
                                    languageCode == 'vi'
                                        ? 'Switch to English'
                                        : 'Chuyển sang tiếng Việt',
                                    style: TextStyle(
                                        fontSize: SpacingUnit.x4,
                                        color: colors.text),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: SpacingUnit.x4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              appLocalizations.notAMember,
                              style:
                                  TextStyle(fontSize: 16, color: colors.text),
                            ),
                            GestureDetector(
                                onTap: () {
                                  onRegister(context);
                                },
                                child: Text(appLocalizations.signUpNow,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xffABBFED)))),
                          ],
                        ),
                        const SizedBox(height: SpacingUnit.x4),
                      ]),
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

  _language(String languageCode) {
    if (languageCode == 'vi') {
      dI<LanguageCubit>().changeLocale('en');
    } else {
      dI<LanguageCubit>().changeLocale('vi');
    }
  }

  void onClickForgotPassword() {
    dI<AppNavigation>().push(context, page: Pages.forgotPasswordPage);
  }

  void onSubmit() {
    setState(() {
      _animationHeight = const AlwaysStoppedAnimation<double>(0);
      _animationWidth = const AlwaysStoppedAnimation<double>(0);
      _controller.forward(from: 0);
    });
    Future.delayed(const Duration(seconds: 1), () {
      dI<LoginBloc>().add(ValidateLogin(
          username: emailController.text, password: passwordController.text));
    });
  }

  void onRegister(context) {
    dI<AppNavigation>().push(context, page: Pages.register);
  }

  bool checkInput() {
    RegExp regExpPass = RegExp(checkPasswordRegexExp);
    RegExp regExpEmail = RegExp(checkEmailRegexExpTest); //
    return (regExpEmail.hasMatch(checkEmail) &&
            regExpPass.hasMatch(checkPassword))
        ? isCheckedInput = true
        : isCheckedInput = false;
  }
}
