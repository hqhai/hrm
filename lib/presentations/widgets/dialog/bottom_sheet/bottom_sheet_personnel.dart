import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_state.dart';
import 'package:base_app/presentations/widgets/custom/search_input.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/item/item_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class BottomSheetPersonnelWidget extends StatefulWidget {
  const BottomSheetPersonnelWidget({
    super.key,
    required this.onChange, this.user,
  });

  final ValueChanged<User> onChange;
  final User? user;

  @override
  State<BottomSheetPersonnelWidget> createState() => _BottomSheetPersonnelWidgetState();
}

class _BottomSheetPersonnelWidgetState extends State<BottomSheetPersonnelWidget> {
  late ScrollController controller;
  String searchStr = '';
  int pageIndex = 1, totalItems = 0, lengthList = 0;
  UserStatus status = UserStatus.init;

  @override
  void initState() {
    dI<UserByNameBloc>().add(const GetUserByNameEvent(page: 1, name: ''));
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocConsumer<UserByNameBloc, UserByNameState>(
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              Text(
                appLocalizations.personnel,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(SpacingUnit.x2),
                child: SearchInput(onChange: (value) => _onChangeSearch(value)),
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: state.usersByName.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => setOnChange(state.usersByName[index]),
                    child: ItemBottomSheet(
                      check: check(state.usersByName[index]),
                      index: index,
                      value: state.usersByName[index].fullName,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool check(User userSelect){
    if(userSelect.id == widget.user?.id){
      return true;
    }
    return false;
  }

  _onChangeSearch(String value) {
    setState(() {
      searchStr = value;
      pageIndex = 1;
    });
    dI<UserByNameBloc>().add(GetUserByNameEvent(page: 1, name: value));
  }

  _scrollListener() {
    if (lengthList < totalItems &&
        status == UserStatus.success &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      dI<UserByNameBloc>().add(GetUserByNameEvent(
        name: searchStr,
        page: pageIndex,
      ));
    }
  }

  _listener(BuildContext context, UserByNameState state) {
    setState(() {
      status = state.status;
      totalItems = state.countItem;
      lengthList = state.usersByName.length;
    });
  }

  setOnChange(User usersByName) {
    widget.onChange.call(usersByName);
  }
}
