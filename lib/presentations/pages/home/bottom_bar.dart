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
            Assets.images.icon.homeSvg,
            colorFilter: ColorFilter.mode(colors.outline, BlendMode.srcIn),
          ),
          label: appLocalizations.home,
          activeIcon: SvgPicture.asset(
            Assets.images.icon.homeSvg,
            colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
          ),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Assets.images.icon.profile,
            colorFilter: ColorFilter.mode(colors.outline, BlendMode.srcIn),
          ),
          label: appLocalizations.account,
          activeIcon: SvgPicture.asset(
            Assets.images.icon.profile,
            colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
          ),
        ),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: colors.text,
      unselectedItemColor: colors.outline,
      onTap: (value) => _setSelectedIndex(value),
    );
  }

  _setSelectedIndex(int value) {
    widget.onChangeSelectedIndex.call(value);
  }
}
