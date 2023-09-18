import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/constants/key_constance.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/storage/local_storage.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/login/login_bloc.dart';
import 'package:base_app/presentations/bloc/login/login_state.dart';
import 'package:base_app/presentations/widgets/base_app_bar.dart';
import 'package:base_app/presentations/widgets/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets/app_button.dart';
import 'package:widgets/app_input.dart';
import 'package:widgets/app_input_password.dart';
import 'package:widgets/app_show_dialog.dart';

final loginPageRoute = GoRoute(
    path: Pages.login,
    builder: (context, GoRouterState state) => const LoginPage());

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordControl = TextEditingController();

  String? rememberEmail = '';
  String? rememberPassword = '';
  String? errorEmail = '';
  String? errorPass = '';

  @override
  void initState() {
    super.initState();
    emailController.text = "";
    passwordControl.text = "";
    _getUsernameSaved();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordControl.dispose();
    super.dispose();
  }

  _getUsernameSaved() async {
    final value = await AppLocalStorage.getData(DataKey.userName);
    if (emailController.text == "") {
      emailController.text = value ?? '';
    }
  }

  _loginListener(BuildContext context, LoginState state) {
    switch (state.status) {
      case LoginStatus.validateSuccess:
        dI<LoginBloc>().add(RequestLogin(
            username: emailController.text, password: passwordControl.text));
      case LoginStatus.validateFailed:
        setState(() {
          errorEmail = 'Required data field';
          errorPass = 'Required data field';
        });
      case LoginStatus.loginSuccess:
      case LoginStatus.statusSuccess:
        passwordControl.text = "";
      case LoginStatus.statusFalse:
        setState(() {
          errorEmail = 'Error email or password';
          errorPass = 'Error email or password';
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
    return BlocListener<LoginBloc, LoginState>(
      listener: _loginListener,
      child: BasePage(
        appbar: appbar(title: 'Login'),
        body: Padding(
          padding: const EdgeInsets.all(SpacingUnit.x8),
          child: Column(children: [
            AppInput(
              placeHolder: 'Username',
              controller: emailController,
            ),
            const SizedBox(height: SpacingUnit.x4),
            AppInputPassword(
              placeHolder: 'Password',
              controller: passwordControl,
            ),
            const SizedBox(height: SpacingUnit.x4),
            AppButton(title: 'Login', onSubmit: onSubmit),
            const SizedBox(height: SpacingUnit.x2),
            AppButton(title: 'Register', onSubmit: onRegister)
          ]),
        ),
      ),
    );
  }

  void onSubmit() {
    dI<LoginBloc>().add(ValidateLogin(
        username: emailController.text, password: passwordControl.text));
  }

  void onRegister() {
    dI<AppNavigation>().push(context, page: Pages.register);
  }
}
