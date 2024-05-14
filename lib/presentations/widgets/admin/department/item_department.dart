import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_event.dart';
import 'package:base_app/presentations/bloc/department/department_state.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemDepartment extends StatefulWidget {
  const ItemDepartment({super.key, this.index = 0});

  final int index;

  @override
  State<ItemDepartment> createState() => _ItemDepartmentState();
}

class _ItemDepartmentState extends State<ItemDepartment> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<DepartmentBloc, DepartmentState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => {}/*_information(context, state)*/,
          child: Container(
            margin: const EdgeInsets.only(bottom: SpacingUnit.x4),
            padding:
                const EdgeInsets.symmetric(vertical: SpacingUnit.x2, horizontal: SpacingUnit.x2),
            decoration: const BoxDecoration(
              color: Color(0xff293656),
              borderRadius: BorderRadius.all(
                Radius.circular(SpacingUnit.x2_5),
              ),
            ),
            height: SpacingUnit.x30,
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xff42558A),
                    child: Text('${widget.index + 1}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: SpacingUnit.x6, color: colors.text)),
                  ),
                ),
                Expanded(
                  flex: 85,
                  child: Padding(
                    padding: const EdgeInsets.only(right: SpacingUnit.x2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          state.departments[widget.index].name,
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: SpacingUnit.x5, color: Colors.orange),
                        ),
                        Text(
                          state.departments[widget.index].address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: SpacingUnit.x4, color: colors.text),
                        ),
                        Text(
                          state.departments[widget.index].phoneNumber,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: SpacingUnit.x4, color: colors.text),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => _deleteDialog(context, state),
                      child: const Icon(Icons.delete, color: Colors.red, size: 24),
                    ),
                    GestureDetector(
                      onTap: () => _update(context),
                      child: const Icon(Icons.edit, color: Colors.amber, size: 24),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _deleteDialog(BuildContext context, DepartmentState state) {
    deleteDialog(
        context,
        () => dI<DepartmentBloc>()
            .add(DeleteDepartmentsEvent(id: state.departments[widget.index].id)));
  }

  _update(BuildContext context){
    dI<AppNavigation>().pushName(context,
        page: Pages.updateDepartmentPage, extra: {'index': widget.index});
  }

  //Chưa có Department by id nên để trống
  // _information(BuildContext context, DepartmentState state){
  //   dI<AppNavigation>().pushName(context,
  //       page: Pages.informationDepartmentPage, extra: {'id': state.departments[widget.index].id});
  // }
}
