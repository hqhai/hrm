import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/explanation.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_state.dart';
import 'package:base_app/presentations/widgets/activate/requisition_info_item/item/item_title_value_no_border.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';
import 'package:collection/collection.dart';

class ItemExplanation extends StatefulWidget {
  final Explanation explanation;

  const ItemExplanation({super.key, required this.explanation});

  @override
  State<ItemExplanation> createState() => _ItemExplanationState();
}

class _ItemExplanationState extends State<ItemExplanation> {
  bool showNote = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<WorkSheetBloc, WorkSheetState>(
      builder: (context, state) {
        return ContainerBorder(
          borderColors: colors.text.withOpacity(0.3),
          paddingVertical: 0,
          paddingHorizontal: SpacingUnit.x2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: SpacingUnit.x1,
                    top: SpacingUnit.x2,
                    bottom: SpacingUnit.x2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatYMD(widget.explanation.workDate.toString()),
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () => setShowNote(),
                      child: SvgPicture.asset(
                        width: SpacingUnit.x8,
                        height: SpacingUnit.x8,
                        showNote
                            ? Assets.images.icon.home.chevronForward
                            : Assets.images.icon.activateIcon.drop,
                        colorFilter: ColorFilter.mode(
                            colors.text.withOpacity(0.4), BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
              ),
              if (state.attendanceByListDates.isNotEmpty && showNote) ...[
                SizedBox(
                  height: SpacingUnit.x4,
                ),
                Column(
                  children: state.attendanceByListDates.last.checkings
                      .mapIndexed((index, e) {
                    DateFormat inputFormat = DateFormat('hh:mm');
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: SpacingUnit.x4,
                                  color: colors.primary,
                                ),
                                SizedBox(
                                  width: SpacingUnit.x1,
                                ),
                                Text(inputFormat.format(e.timeChecking)),
                              ],
                            ),
                            Text(
                              e.checkInMethod.name,
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: colors.primary),
                            ),
                          ],
                        ),
                        if (index < state.attendanceByListDates.length - 1) ...[
                          Container(
                            width: SpacingUnit.x4,
                            alignment: Alignment.center,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: SpacingUnit.x7,
                              width: 1,
                              color: colors.primary,
                            ),
                          ),
                        ]
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: SpacingUnit.x4,
                ),
              ],
              if (showNote) ...[
                ItemTitleValueNoBorder(
                  size: SpacingUnit.x4,
                  title: appLocalizations.realCheckIn,
                  value: strSeconds(widget.explanation.checkIn) ?? "",
                ),
                ItemTitleValueNoBorder(
                    size: SpacingUnit.x4,
                    title: appLocalizations.realCheckOut,
                    value: strSeconds(widget.explanation.checkOut) ?? ""),
                const SizedBox(
                  height: SpacingUnit.x2,
                ),
                Text(
                  appLocalizations.note,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
                ContainerBorder(
                  borderColors: colors.text.withOpacity(0.3),
                  paddingVertical: SpacingUnit.x4,
                  height: SpacingUnit.x30,
                  width: width,
                  child: SingleChildScrollView(
                    child: Text(
                      widget.explanation.note,
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x4,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: SpacingUnit.x2,
                )
              ],
            ],
          ),
        );
      },
    );
  }

  setShowNote() {
    setState(() {
      showNote = !showNote;
    });
  }
}
