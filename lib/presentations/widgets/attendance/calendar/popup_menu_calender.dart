
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class PopupMenuCalender extends StatefulWidget {
  const PopupMenuCalender({super.key, required this.onChangeCheckOpacity, required this.displayType});

  final ValueChanged<bool> onChangeCheckOpacity;
  final ValueChanged<int> displayType;

  @override
  State<PopupMenuCalender> createState() => _PopupMenuCalenderState();
}

class _PopupMenuCalenderState extends State<PopupMenuCalender> {
  bool checkOpacity = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return PopupMenuButton(
      icon: SvgPicture.asset(
        Assets.images.icon.home.worksheet.worksheet1,
        colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
      ),
      onOpened: () => widget.onChangeCheckOpacity(!checkOpacity),
      onCanceled: () => widget.onChangeCheckOpacity(checkOpacity),
      itemBuilder: (_) => [
        PopupMenuItem(
          child: PopUpMenuWorkSheet(
            title: appLocalizations.timeWork,
            callBack: () => _timeWork(),
            icon: Assets.images.icon.home.worksheet.timeCheck,
          ),
        ),
        PopupMenuItem(
          child: PopUpMenuWorkSheet(
            title: appLocalizations.detailWork,
            callBack: () => () => _detail(),
            icon: Assets.images.icon.home.worksheet.detail,
          ),
        ),
        PopupMenuItem(
          child: PopUpMenuWorkSheet(
            title: appLocalizations.summary,
            callBack: () => _synthetic(),
            icon:  Assets.images.icon.home.worksheet.summary,
          ),
        ),
      ],
    );
  }

  _timeWork() {
    widget.displayType.call(1);
  }

  _detail() {
    widget.displayType.call(2);
  }

  _synthetic() {
    widget.displayType.call(3);
  }
}

class PopUpMenuWorkSheet extends StatelessWidget {
  const PopUpMenuWorkSheet({super.key, required this.title, required this.icon, required this.callBack});

  final String title;
  final String icon;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return InkWell(
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
              style: const TextStyle(
                fontSize: SpacingUnit.x3_5,
              ),
            ),
            const SizedBox(
              width: SpacingUnit.x6,
            ),
          ],
        ),
    );
  }
}
