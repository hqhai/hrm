import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class WarpInDialog extends StatelessWidget {
  const WarpInDialog({super.key, this.statuses = const [], required this.onChange});

  final List<StatusRequestEnum> statuses;
  final ValueChanged<List<StatusRequestEnum>> onChange;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.status,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: SpacingUnit.x4, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: SpacingUnit.x3),
        Wrap(
          spacing: SpacingUnit.x4,
          runSpacing: SpacingUnit.x3,
          children: StatusRequestEnum.values
              .map(
                (eStatus) => GestureDetector(
                  onTap: () => saveDrag(eStatus: eStatus),
                  child: Container(
                    padding: const EdgeInsets.all(SpacingUnit.x1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SpacingUnit.x1),
                      color:
                          statuses.contains(eStatus) ? colors.error : CustomsColor.colorBackground,
                      border: Border.all(color: colors.text, width: SpacingUnit.x0_25),
                    ),
                    child: Text(eStatus.configRequestStatusName),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  void saveDrag({required StatusRequestEnum eStatus}) {
    final List<StatusRequestEnum> listStatuses = [...statuses];
    if (!statuses.contains(eStatus)) {
      listStatuses.add(eStatus);
      onChange.call(listStatuses);
    } else {
      listStatuses.remove(eStatus);
      onChange.call(listStatuses);
    }
  }
}
