import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/attendance/calendar/item/color_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class PopupMenuCalender extends StatefulWidget {
  const PopupMenuCalender({super.key,
    required this.onChangeCheckOpacity,
    required this.displayType,
    required this.index});

  final ValueChanged<bool> onChangeCheckOpacity;
  final ValueChanged<int> displayType;
  final int index;

  @override
  State<PopupMenuCalender> createState() => _PopupMenuCalenderState();
}

class _PopupMenuCalenderState extends State<PopupMenuCalender> {
  bool checkOpacity = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return PopupMenuButton<int>(
      color: colors.background,
      initialValue: widget.index,
      icon: SvgPicture.asset(
        Assets.images.icon.home.worksheet.worksheet1,
        colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
      ),
      onOpened: () => widget.onChangeCheckOpacity(!checkOpacity),
      onCanceled: () => widget.onChangeCheckOpacity(checkOpacity),
      onSelected: (value) => setClick(value),
      itemBuilder: (context) =>
      [
        PopupMenuItem<int>(
          value: 1,
          height: SpacingUnit.x9,
          child: PopUpMenuWorkSheet(
            title: appLocalizations.timeWork,
            icon: Assets.images.icon.home.worksheet.timeCheck,
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          height: SpacingUnit.x9,
          child: PopUpMenuWorkSheet(
            title: appLocalizations.detailWork,
            icon: Assets.images.icon.home.worksheet.detail,
          ),
        ),
        PopupMenuItem<int>(
          value: 3,
          height: SpacingUnit.x9,
          child: PopUpMenuWorkSheet(
            title: appLocalizations.summary,
            icon: Assets.images.icon.home.worksheet.summary,
          ),
        ),
        const PopupMenuItem(child: ColorPopUp()),
      ],
    );
  }

  setClick(int value) {
    widget.displayType.call(value);
    widget.onChangeCheckOpacity(checkOpacity);
  }
}

class PopUpMenuWorkSheet extends StatelessWidget {
  const PopUpMenuWorkSheet({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Row(
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
            color: colors.text,
            fontSize: SpacingUnit.x3_5,
          ),
        ),
        const SizedBox(
          width: SpacingUnit.x6,
        ),
      ],
    );
  }
}
