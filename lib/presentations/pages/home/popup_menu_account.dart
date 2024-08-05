import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class PopupMenuAccount extends StatefulWidget {
  const PopupMenuAccount({super.key, required this.onChangeCheckOpacity});

  final ValueChanged<bool> onChangeCheckOpacity;

  @override
  State<PopupMenuAccount> createState() => _PopupMenuAccountState();
}

class _PopupMenuAccountState extends State<PopupMenuAccount> {
  bool checkOpacity = false;

  _language(BuildContext context, LanguageState state) {
    if (state.languageCode == LanguageEnum.en) {
      dI<LanguageCubit>().changeLocale(LanguageEnum.vi);
      Navigator.of(context).pop();
    } else {
      dI<LanguageCubit>().changeLocale(LanguageEnum.en);
      Navigator.of(context).pop();
    }
  }

  _editPersonalInformation() {
    dI<AppNavigation>().push(context, page: Pages.updateProfilePage);
  }

  _setting(BuildContext context) {
    dI<AppNavigation>().push(context, page: Pages.biometricRegister);
  }

  _changePassword(BuildContext context) {
    dI<AppNavigation>().push(context, page: Pages.changePasswordPage);
  }

  void logoutFunction() {
    dI<AuthBloc>().add(const LogoutEvent());
    dI<UserBloc>().add(const ResetUserEvent());
    dI<UserByRolesBloc>().add(const ResetUsersEvent());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return PopupMenuButton(
      icon: SvgPicture.asset(
        Assets.images.icon.popupAppbar.miOptionsVertical,
        colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
      ),
      onOpened: () => widget.onChangeCheckOpacity(!checkOpacity),
      onCanceled: () => widget.onChangeCheckOpacity(checkOpacity),
      itemBuilder: (_) => [
        item(
          context: context,
          title: appLocalizations.editPersonalInformation,
          icon: Assets.images.icon.popupAppbar.suaThongTinCaNhan,
          callBack: () => _editPersonalInformation(),
        ),
        item(
          context: context,
          title: appLocalizations.setting,
          icon: Assets.images.icon.popupAppbar.caiDat,
          callBack: () => _setting(context),
        ),
        item(
          context: context,
          title: appLocalizations.changePassword,
          icon: Assets.images.icon.popupAppbar.doiMatKhau,
          callBack: () => _changePassword(context),
        ),
        PopupMenuItem(
          child: BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, stateLanguage) {
              return InkWell(
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
                      style: TextStyle(
                        fontSize: SpacingUnit.x3_5,
                        color: colors.text,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        item(
          context: context,
          title: appLocalizations.logout,
          icon: Assets.images.icon.popupAppbar.dangXuat,
          callBack: () => logoutFunction(),
        ),
      ],
    );
  }

  PopupMenuItem item({
    required VoidCallback callBack,
    required BuildContext context,
    required String title,
    required String icon,
  }) {
    final colors = AppTheme.getColors(context);
    return PopupMenuItem(
      child: InkWell(
        onTap: () => callBack.call(),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
            ),
            const SizedBox(
              width: SpacingUnit.x3,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: SpacingUnit.x3_5,
                color: colors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
