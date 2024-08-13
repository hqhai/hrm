import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
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
import 'package:widgets/app_button.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    super.key,
    required this.onChange,
    this.oldUser = const [],
  });

  final ValueChanged<List<User>> onChange;
  final List<User> oldUser;

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  List<String> listPerson = [];
  List<User> users = [];
  String searchStr = '';
  bool checkLoad = true;
  late ScrollController controller;
  int pageIndex = 1, totalItems = 12, lengthList = 11;
  UserStatus status = UserStatus.init;

  @override
  void initState() {
    final idsOld = widget.oldUser.map((e) => e.id).toList();
    listPerson = [...idsOld];
    users = [...widget.oldUser];
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<UserByNameBloc, UserByNameState>(
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Container(
          color: colors.text.withOpacity(0.1),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x2),
                  child:
                      SearchInput(onChange: (value) => _onChangeSearch(value)),
                ),
                Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: state.usersByName.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => addListPerson(
                            user: state.usersByName[index],
                            listValueByIndex: state.usersByName[index].id),
                        child: Container(
                          padding: const EdgeInsets.all(SpacingUnit.x4),
                          margin: const EdgeInsets.all(SpacingUnit.x2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(SpacingUnit.x2),
                            color:
                                listPerson.contains(state.usersByName[index].id)
                                    ? colors.success
                                    : colors.background,
                            border: Border.all(
                              color: colors.background,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            state.usersByName[index].fullName,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x4),
                  child: AppButton(
                    color: colors.blue.withOpacity(0.8),
                    colorText: colors.background,
                    title: appLocalizations.add,
                    onSubmit: () => setOnChange(),
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

  _scrollListener() async {
    if (lengthList < totalItems &&
        controller.position.extentAfter < totalItems &&
        checkLoad) {
      setState(() {
        pageIndex++;
        checkLoad = false;
      });
      final Completer completer = Completer<bool>();
      dI<UserByNameBloc>().add(GetUserByNameEvent(
          name: searchStr, page: pageIndex, completer: completer));
      final check = await completer.future;
      if (check) {
        setState(() {
          checkLoad = true;
        });
      }
    }
  }

  _listener(BuildContext context, UserByNameState state) {
    setState(() {
      totalItems = state.countItem;
      lengthList = state.usersByName.length;
    });
  }
}
