import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class BottomBarDefault extends StatefulWidget {
  const BottomBarDefault(
      {super.key, required this.selectedIndex, required this.onChangeSelectedIndex});

  final int selectedIndex;
  final ValueChanged<int> onChangeSelectedIndex;

  @override
  State<BottomBarDefault> createState() => _BottomBarDefaultState();
}

class _BottomBarDefaultState extends State<BottomBarDefault> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BottomNavigationBar(
      showUnselectedLabels: true,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        item(
          title: appLocalizations.worksheet,
          icon:  Assets.images.icon.home.bottomBar.home,
          color1: colors.text,
          color2: colors.blue,
        ),
        item(
          title: appLocalizations.request,
          icon: Assets.images.icon.home.bottomBar.document,
          color1: colors.text,
          color2: colors.blue,
        ),
        item(
          title: appLocalizations.calendarWork,
          icon:  Assets.images.icon.home.bottomBar.calendar,
          color1: colors.text,
          color2: colors.blue,
        ),
        item(
          title: appLocalizations.account,
          icon:  Assets.images.icon.home.bottomBar.profile,
          color1: colors.text,
          color2: colors.blue,
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: colors.blue,
      unselectedItemColor: colors.text,
      onTap: (value) => _setSelectedIndex(value),
    );
  }

  _setSelectedIndex(int value) {
    widget.onChangeSelectedIndex.call(value);
  }

  BottomNavigationBarItem item({
    required String icon,
    required String title,
    required Color color1,
    required Color color2,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(color1, BlendMode.srcIn),
      ),
      label: title,
      activeIcon: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(color2, BlendMode.srcIn),
      ),
    );
  }
}
