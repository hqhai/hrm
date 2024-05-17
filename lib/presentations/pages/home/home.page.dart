import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final homePageRoute =
    GoRoute(path: Pages.home, builder: (context, GoRouterState state) => const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  bool checkOpacity = false;

  @override
  void initState() {
    if (AppConfig.getToken.isNotEmpty) {
      dI<UserBloc>().add(const GetUserInfo());
    }
    super.initState();
  }

  void selectedIndexFunction(dynamic entry) {
    setState(() {
      selectedIndex = entry.key;
      Navigator.pop(context);
    });
  }

  void logoutFunction() {
    setState(() {
      dI<AuthBloc>().add(const LogoutEvent());
      dI<RequestBloc>().add(const ResetRequestEvent());
      dI<UserBloc>().add(const ResetUserEvent());
      dI<UserByRolesBloc>().add(const ResetUsersEvent());
    });
  }

  _listener(BuildContext context, UserState state) {
    if (state.status == UserStatus.getUserInfoErrorUnauthorized) {
      logoutFunction();
    }
  }

  _language(BuildContext context, LanguageState state) {
    if (state.languageCode == LanguageEnum.en) {
      dI<LanguageCubit>().changeLocale(LanguageEnum.vi);
      Navigator.of(context).pop();
    } else {
      dI<LanguageCubit>().changeLocale(LanguageEnum.en);
      Navigator.of(context).pop();
    }
  }

  _editPersonalInformation() {}

  _setting() {}

  _changePassword() {}

  _opacity() {
    setState(() {
      checkOpacity = !checkOpacity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, stateUser) {
        _listener(context, stateUser);
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, stateUser) {
        return Scaffold(
          appBar: AppBar(
            title: Text(titleValue(context, selectedIndex)),
            actions: [
              PopupMenuButton(
                icon: SvgPicture.asset(
                  Assets.images.icon.popupAppbar.miOptionsVertical,
                  colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                ),
                onOpened: () => _opacity(),
                onCanceled: () => _opacity(),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    child: GestureDetector(
                      onTap: () => _editPersonalInformation(),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.images.icon.popupAppbar.suaThongTinCaNhan,
                            colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: SpacingUnit.x3,
                          ),
                          Text(
                            appLocalizations.editPersonalInformation,
                            style: const TextStyle(
                              fontSize: SpacingUnit.x3_5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: GestureDetector(
                      onTap: () => _setting(),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.images.icon.popupAppbar.caiDat,
                            colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: SpacingUnit.x3,
                          ),
                          Text(
                            appLocalizations.setting,
                            style: const TextStyle(
                              fontSize: SpacingUnit.x3_5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: GestureDetector(
                      onTap: () => _changePassword(),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.images.icon.popupAppbar.doiMatKhau,
                            colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: SpacingUnit.x3,
                          ),
                          Text(
                            appLocalizations.changePassword,
                            style: const TextStyle(
                              fontSize: SpacingUnit.x3_5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: BlocBuilder<LanguageCubit, LanguageState>(
                      builder: (context, stateLanguage) {
                        return GestureDetector(
                          onTap: () => _language(context, stateLanguage),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Assets.images.icon.popupAppbar.ngonNgu,
                                colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                              ),
                              const SizedBox(
                                width: SpacingUnit.x3,
                              ),
                              Text(
                                stateLanguage.languageCode.name,
                                style: const TextStyle(
                                  fontSize: SpacingUnit.x3_5,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: GestureDetector(
                      onTap: () => logoutFunction(),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.images.icon.popupAppbar.dangXuat,
                            colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: SpacingUnit.x3,
                          ),
                          Text(
                            appLocalizations.logout,
                            style: const TextStyle(
                              fontSize: SpacingUnit.x3_5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.images.icon.activate,
                  colorFilter: ColorFilter.mode(colors.outline, BlendMode.srcIn),
                ),
                label: appLocalizations.activate,
                activeIcon: SvgPicture.asset(
                  Assets.images.icon.activate,
                  colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.images.icon.home,
                  colorFilter: ColorFilter.mode(colors.outline, BlendMode.srcIn),
                ),
                label: appLocalizations.home,
                activeIcon: SvgPicture.asset(
                  Assets.images.icon.home,
                  colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Assets.images.icon.profile,
                  colorFilter: ColorFilter.mode(colors.outline, BlendMode.srcIn),
                ),
                label: appLocalizations.profile,
                activeIcon: SvgPicture.asset(
                  Assets.images.icon.profile,
                  colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                ),
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: colors.text,
            unselectedItemColor: colors.outline,
            onTap: _onItemTapped,
          ),
          body: Opacity(
            opacity: checkOpacity ? 0.5 : 1,
            child: MenuValues.widgetOptionsUser.elementAt(selectedIndex),
          ),
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  String titleValue(BuildContext context, int index) {
    return TitleAppbarValues.listTitleAppbar(context).elementAt(index);
  }
}
