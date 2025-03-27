import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/register/register_bloc.dart';
import 'package:base_app/presentations/bloc/register/register_state.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/register/dots_indicator.dart';
import 'package:base_app/presentations/widgets/register/register_email_widget.dart';
import 'package:base_app/presentations/widgets/register/register_password.dart';
import 'package:base_app/presentations/widgets/register/register_username.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final registerPageRoute = GoRoute(
    path: Pages.register,
    builder: (context, GoRouterState state) => const RegisterPage());

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  late final TabController tabController;
  late PageController pageViewController;
  int currentIndex = 0;
  List<bool> checkInputs = [false, false, false];
  List<String> valueInputs = [
    '',
    '123',
    '123',
    GenderEnum.male.name,
    'Admin@123',
    'Admin@123'
  ];

  @override
  void initState() {
    pageViewController = PageController();
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    tabController.dispose();
    super.dispose();
  }

  _listener(BuildContext context, RegisterState state) {
    if (state.requestStatus == RegisterRequestStatus.registerInit) {
      progressIndicatorDialog(context);
    } else if (state.requestStatus == RegisterRequestStatus.registerSuccess) {
      successDialog(context, onPress: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    } else if (state.requestStatus == RegisterRequestStatus.registerError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: colors.background,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.all(SpacingUnit.x4),
            color: colors.outline.withValues(alpha: 0.1),
            child: Padding(
              padding: const EdgeInsets.all(SpacingUnit.x8),
              child: Column(children: [
                const SizedBox(height: SpacingUnit.x4),
                Image.asset(
                  Assets.images.signIn.logo.path,
                ),
                const SizedBox(height: SpacingUnit.x10_5),
                DotsIndicator(
                  width: SpacingUnit.x13,
                  height: SpacingUnit.x1_5,
                  currentIndex: currentIndex.toInt(),
                  pageCount: 3,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: PageView(
                    controller: pageViewController,
                    onPageChanged: _handlePageViewChanged,
                    children: [
                      SingleChildScrollView(
                        child: RegisterEmail(
                          onChange: (value) => checkInputs0(value),
                          onChangeEmail: (value) => valueInputs0(value),
                          emailDefault: state.registerRequest.email,
                        ),
                      ),
                      SingleChildScrollView(
                        child: RegisterUsername(
                          onChange: (value) => checkInputs1(value),
                          onChangeFirstName: (value) => valueInputs1(value),
                          onChangeLastName: (value) => valueInputs2(value),
                          firstNameDefault: state.registerRequest.firstName,
                          lastNameDefault: state.registerRequest.lastName,
                        ),
                      ),
                      SingleChildScrollView(
                        child: RegisterPassword(
                          onChange: (value) => checkInputs2(value),
                          onChangePassword: (value) => valueInputs5(value),
                          passwordDefault: state.registerRequest.password,
                        ),
                      )
                    ],
                  ),
                ),
                PageIndicator(
                  currentPageIndex: currentIndex,
                  tabController: tabController,
                  checkInput: checkInputs,
                  valueInputs: valueInputs,
                  onUpdateCurrentPageIndex: updateCurrentPageIndex,
                ),
                // const Expanded(
                //   child: SizedBox(),
                // ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appLocalizations.alreadyAMember,
                      style: TextStyle(
                          fontSize: SpacingUnit.x4, color: colors.text),
                    ),
                    GestureDetector(
                      onTap: () => onLogin(context),
                      child: Text(
                        appLocalizations.logInNow,
                        style: const TextStyle(
                            fontSize: SpacingUnit.x4, color: Color(0xffABBFED)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SpacingUnit.x4),
              ]),
            ),
          ),
        );
      },
    );
  }

  void onLogin(context) {
    dI<AppNavigation>().pop(context);
  }

  void _handlePageViewChanged(int currentPageIndex) {
    tabController.index = currentPageIndex;
    setState(() {
      currentIndex = currentPageIndex;
    });
  }

  void updateCurrentPageIndex(int index) {
    tabController.index = index;
    pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  checkInputs0(bool value) {
    setState(() {
      checkInputs[0] = value;
    });
  }

  checkInputs1(bool value) {
    setState(() {
      checkInputs[1] = value;
    });
  }

  checkInputs2(bool value) {
    setState(() {
      checkInputs[2] = value;
    });
  }

  valueInputs0(String value) {
    setState(() {
      valueInputs[0] = value;
    });
  }

  valueInputs1(String value) {
    setState(() {
      valueInputs[1] = value;
    });
  }

  valueInputs2(String value) {
    setState(() {
      valueInputs[2] = value;
    });
  }

  valueInputs4(String value) {
    setState(() {
      valueInputs[4] = value;
    });
  }

  valueInputs3(GenderEnum value) {
    setState(() {
      valueInputs[3] = value.name;
    });
  }

  valueInputs5(String value) {
    setState(() {
      valueInputs[5] = value;
    });
  }
}
