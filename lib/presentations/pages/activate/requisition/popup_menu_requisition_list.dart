import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
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

class PopupMenuRequisitionList extends StatefulWidget {
  const PopupMenuRequisitionList({super.key, required this.onChangeCheckOpacity});

  final ValueChanged<bool> onChangeCheckOpacity;

  @override
  State<PopupMenuRequisitionList> createState() => _PopupMenuRequisitionListState();
}

class _PopupMenuRequisitionListState extends State<PopupMenuRequisitionList> {

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

  void logoutFunction() {
    setState(() {
      dI<AuthBloc>().add(const LogoutEvent());
      dI<UserBloc>().add(const ResetUserEvent());
      dI<UserByRolesBloc>().add(const ResetUsersEvent());
    });
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
    );
  }
}
