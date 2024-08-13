import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/leave/filter_leave_history_model.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/bloc/leave/leave_history/leave_history_bloc.dart';
import 'package:base_app/presentations/bloc/leave/leave_history/leave_history_event.dart';
import 'package:base_app/presentations/bloc/leave/leave_history/leave_history_state.dart';
import 'package:base_app/presentations/pages/activate/leave/item_leave_history.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_type_leave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ListLeaveHistoryWidget extends StatefulWidget {
  const ListLeaveHistoryWidget({
    super.key,
  });

  @override
  State<ListLeaveHistoryWidget> createState() => _ListLeaveHistoryWidgetState();
}

class _ListLeaveHistoryWidgetState extends State<ListLeaveHistoryWidget> {
  FilterLeaveHistoryModel filterLeaveHistoryModel =
      const FilterLeaveHistoryModel();
  DateTime? date;
  TypeLeaveEnum? type;
  late ScrollController controller;
  int pageIndex = 1, totalItems = 12, lengthList = 11;
  bool checkLoadMore = true;

  @override
  void initState() {
    dI<LeaveHistoryBloc>().add(GetLeaveHistoryEvent(page: 1, time: date));
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() async {
    if (lengthList < totalItems &&
        checkLoadMore == true &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      final Completer completer = Completer<bool>();
      setState(() {
        checkLoadMore = false;
      });
      dI<LeaveHistoryBloc>().add(
        GetLeaveHistoryEvent(
          type: type,
          time: date,
          page: pageIndex,
          completer: completer,
        ),
      );
      final check = await completer.future;
      if (check) {
        setState(() {
          checkLoadMore = true;
        });
      }
    }
  }

  _listener(LeaveHistoryState state) {
    setState(() {
      totalItems = state.totalItems;
      lengthList = state.listIds.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocConsumer<LeaveHistoryBloc, LeaveHistoryState>(
      listener: (context, state) => _listener(state),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: SpacingUnit.x3),
                  child: GestureDetector(
                    onTap: () => _addType(context),
                    child: Container(
                      color: colors.scaffoldBackground,
                      child: SvgPicture.asset(
                        Assets.images.icon.activateIcon.iconamoonOptionsThin,
                        colorFilter:
                            ColorFilter.mode(colors.text, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: ListView.builder(
                  controller: controller,
                  itemCount: state.listIds.length,
                  itemBuilder: (context, index) => ItemLeaveHistory(
                      userLeaveHistoryId: state.listIds[index]),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _addType(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetTypeLeaveWidget(
          filterOld: filterLeaveHistoryModel,
          onChange: (value) => setType(value),
        );
      },
    );
  }

  setType(FilterLeaveHistoryModel value) async {
    setState(() {
      filterLeaveHistoryModel = value;
      date = value.date;
      type = value.type;
      pageIndex = 1;
    });
    final Completer completer = Completer<bool>();
    dI<LeaveHistoryBloc>().add(
      GetLeaveHistoryEvent(
        type: type,
        time: date,
        page: pageIndex,
        completer: completer,
      ),
    );
    await completer.future;
  }
}
