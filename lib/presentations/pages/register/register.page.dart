import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/base_app_bar.dart';
import 'package:base_app/presentations/widgets/base_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets/app_button.dart';
import 'package:widgets/app_input.dart';
import 'package:widgets/app_input_password.dart';

final registerPageRoute = GoRoute(
    path: Pages.register,
    builder: (context, GoRouterState state) => const RegisterPage());

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appbar: appbar(title: 'Register'),
      body: Padding(
        padding: const EdgeInsets.all(SpacingUnit.x8),
        child: Column(children: [
          const AppInput(placeHolder: 'Username'),
          const SizedBox(height: SpacingUnit.x4),
          const AppInputPassword(placeHolder: 'Password'),
          const SizedBox(height: SpacingUnit.x4),
          AppButton(title: 'Register', onSubmit: onSubmit),
          const SizedBox(height: SpacingUnit.x2),
          AppButton(title: 'Login', onSubmit: () => onLogin(context))
        ]),
      ),
    );
  }

  void onLogin(context) {
    dI<AppNavigation>().pop(context);
  }

  void onSubmit() {}
}
