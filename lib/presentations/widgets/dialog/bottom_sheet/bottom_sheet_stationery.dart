import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/stationery_enum.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/stationery/stationery.dart';
import 'package:base_app/presentations/bloc/requisition/stationery/stationery_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/stationery/stationery_event.dart';
import 'package:base_app/presentations/bloc/requisition/stationery/stationery_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_event.dart';
import 'package:base_app/presentations/widgets/custom/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class BottomSheetStationeryWidget extends StatefulWidget {
  const BottomSheetStationeryWidget({
    super.key,
    required this.onChange,
  });

  final ValueChanged<Stationery> onChange;

  @override
  State<BottomSheetStationeryWidget> createState() => _BottomSheetStationeryWidgetState();
}

class _BottomSheetStationeryWidgetState extends State<BottomSheetStationeryWidget> {
  late ScrollController controller;
  String? searchStr;
  int pageIndex = 1, totalItems = 0, lengthList = 0;
  StationeryStatus status = StationeryStatus.init;

  @override
  void initState() {
    dI<StationeryBloc>().add(const GetStationeriesEvent());
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.of(context).size.height;
    return BlocConsumer<StationeryBloc, StationeryState>(
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Container(
          height: height * 0.6,
          color: colors.surface,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x2),
                  child: SearchInput(onChange: (value) => _onChangeSearch(value)),
                ),
                SizedBox(
                  height: height * 0.4,
                  child: ListView.builder(
                    controller: controller,
                    itemCount: state.stationeries.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => setOnChange(
                        stationery: state.stationeries[index],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(SpacingUnit.x2),
                        margin: const EdgeInsets.all(SpacingUnit.x2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SpacingUnit.x2),
                          color: CustomsColor.colorBackground,
                          border: Border.all(
                            color: colors.text,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${index + 1}.    ',
                              style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x3,
                              ),
                            ),
                            Text(
                              state.stationeries[index].product ?? "",
                              style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  setOnChange({required Stationery stationery}) {
    widget.onChange.call(stationery);
    Navigator.of(context).pop();
  }

  _onChangeSearch(String value) {
    setState(() {
      searchStr = value;
    });
    dI<UserByNameBloc>().add(GetUserByNameEvent(page: 1, name: value));
  }

  _scrollListener() {
    if (lengthList <= totalItems &&
        status == StationeryStatus.success &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      dI<StationeryBloc>().add(GetStationeriesEvent(
        name: searchStr ?? "",
        page: pageIndex,
      ));
    }
  }

  _listener(BuildContext context, StationeryState state) {
    setState(() {
      status = state.status;
      totalItems = state.countItem;
      lengthList = state.stationeries.length;
    });
  }
}
