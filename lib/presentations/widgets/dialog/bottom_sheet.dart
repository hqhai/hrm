import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_state.dart';
import 'package:base_app/presentations/widgets/custom/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    super.key,
    required this.onChange,
  });

  final ValueChanged<List<User>> onChange;

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  List<String> listPerson = [];
  List<User> users = [];
  String searchStr = '';
  late ScrollController controller;
  int pageIndex = 1, totalItems = 0, lengthList = 0;
  UserStatus status = UserStatus.getUsersByNameInit;

  @override
  void initState() {
    dI<UserByNameBloc>().add(const GetUserByNameEvent(page: 1, name: ''));
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<UserByNameBloc, UserByNameState>(
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
                    itemCount: state.usersByName.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => addListPerson(
                          user: state.usersByName[index],
                          listValueByIndex: state.usersByName[index].fullName ?? ""),
                      child: Container(
                        padding: const EdgeInsets.all(SpacingUnit.x2),
                        margin: const EdgeInsets.all(SpacingUnit.x2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SpacingUnit.x2),
                          color: listPerson.contains(state.usersByName[index].fullName)
                              ? colors.tertiary
                              : CustomsColor.colorBackground,
                          border: Border.all(
                            color: colors.text,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                             '${index+1}.    ',
                              style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x3,
                              ),
                            ),
                            Text(
                              state.usersByName[index].fullName ?? "",
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
                ElevatedButton(
                  onPressed: () => setOnChange(),
                  style: ElevatedButton.styleFrom(backgroundColor: colors.blue),
                  child: Text(
                    appLocalizations.add,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x3,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  addListPerson({required String listValueByIndex, required User user}) {
    setState(() {
      if (!listPerson.contains(listValueByIndex)) {
        listPerson.add(listValueByIndex);
        users.add(user);
      } else {
        listPerson.remove(listValueByIndex);
        users.remove(user);
      }
    });
  }

  setOnChange() {
    widget.onChange.call(users);
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
        status == UserStatus.getUsersByNameSuccess &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      dI<UserByNameBloc>()
          .add(GetUserByNameEvent(name: searchStr, page: pageIndex,));
    }
  }

  _listener(BuildContext context, UserByNameState state) {
    setState(() {
      status = state.status;
      totalItems = state.countItem;
      lengthList = state.usersByName.length;
    });
  }
}
