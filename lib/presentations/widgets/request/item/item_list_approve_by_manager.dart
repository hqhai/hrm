import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemListApproveByManager extends StatefulWidget {
  const ItemListApproveByManager(
      {super.key,
      this.index = 0,
      this.dropdownTypeRequestValue = '',
      required this.onChangeStatus,
      required this.callback});

  final int index;
  final String dropdownTypeRequestValue;
  final ValueChanged<String> onChangeStatus;
  final VoidCallback callback;

  @override
  State<ItemListApproveByManager> createState() => _ItemListApproveByManagerState();
}

class _ItemListApproveByManagerState extends State<ItemListApproveByManager> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequestBloc, RequestState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
          padding: const EdgeInsets.all(SpacingUnit.x2),
          decoration: const BoxDecoration(
            color: Color(0xff293656),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.requests[widget.index].createdFullName??'',
                      style: TextStyle(fontSize: SpacingUnit.x4, color: colors.text),
                    ),
                    if (widget.dropdownTypeRequestValue != TypeRequestStatus.overTime.name)
                      Text(
                        state.requests[widget.index].title.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: SpacingUnit.x4, color: colors.text),
                      ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => widget.callback.call(),/*_openDialog(context, widget.index),*/
                child: const Icon(
                  Icons.note,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: SpacingUnit.x3,
              ),
              DropdownMenu<String>(
                width: 100,
                textStyle: const TextStyle(
                  fontSize: SpacingUnit.x3,
                ),
                initialSelection: state.requests[widget.index].status,
                onSelected: (String? value) {
                  setState(() {
                    widget.onChangeStatus.call(value!);
                    /*listDropdownCheckApproverValue[widget.index] = value!;*/
                  });
                },
                dropdownMenuEntries: _dropdownMenuEntries(),
              ),
            ],
          ),
        );
      },
    );
  }

  List<DropdownMenuEntry<String>> _dropdownMenuEntries() {
    return _checkRole()
        ? MenuValues.checkApprover.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList()
        : MenuValues.checkManagerApprover.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList();
  }

  bool _checkRole() {
    return dI<UserBloc>().state.user.role.toString() == ConfigStringValues.manager.name;
  }
}
