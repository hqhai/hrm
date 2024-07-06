import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/leave/leave_history/leave_history_bloc.dart';
import 'package:base_app/presentations/bloc/leave/leave_history/leave_history_event.dart';
import 'package:base_app/presentations/bloc/leave/leave_history/leave_history_state.dart';
import 'package:base_app/presentations/pages/activate/leave/item_leave_history.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_add.dart';
import 'package:base_app/presentations/widgets/custom/app_month_year_picker.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_type_leave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ListLeaveHistoryWidget extends StatefulWidget {
  const ListLeaveHistoryWidget({
    super.key,
  });

  @override
  State<ListLeaveHistoryWidget> createState() => _ListLeaveHistoryWidgetState();
}

class _ListLeaveHistoryWidgetState extends State<ListLeaveHistoryWidget> {
  DateTime date = DateTime.now();
  TypeLeaveEnum? type;

  @override
  void initState() {
    dI<LeaveHistoryBloc>().add(GetLeaveHistoryEvent(page: 1, time: date));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<LeaveHistoryBloc, LeaveHistoryState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MonthYearPicker(
              onChange: (value) => setDate(value),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ItemAdd(
                  callback: () => _addType(context),
                  title: appLocalizations.type,
                ),
                if (type != null)
                  Row(
                    children: [
                      Text(
                        type!.configTypeLeaveEnum,
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x4,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _deleteType(),
                        child: Icon(
                          Icons.delete,
                          color: colors.error,
                          size: SpacingUnit.x6,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            Expanded(
              flex: 4,
              child: ListView.builder(
                itemCount:  state.listIds.length,
                itemBuilder: (context, index) =>
                    ItemLeaveHistory(userLeaveHistoryId: state.listIds[index]),
              ),
            )
          ],
        );
      },
    );
  }

  setDate(DateTime value) {
    setState(() {
      date = value;
    });
  }

  _addType(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetTypeLeaveWidget(
          onChange: (value) => setType(value),
        );
      },
    );
  }

  setType(TypeLeaveEnum value) {
    setState(() {
      type = value;
    });
  }

  _deleteType() {
    setState(() {
      type = null;
    });
  }
}
