import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_department.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_personnel.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class AddDepartmentAndUser extends StatefulWidget {
  const AddDepartmentAndUser({
    super.key,
    required this.setUser,
    required this.setDepartment,
    this.user,
    this.department,
  });

  final ValueChanged<User> setUser;
  final ValueChanged<Department> setDepartment;
  final User? user;
  final Department? department;

  @override
  State<AddDepartmentAndUser> createState() => _AddDepartmentAndUserState();
}

class _AddDepartmentAndUserState extends State<AddDepartmentAndUser> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          item(
            title: appLocalizations.department,
            context: context,
            value: widget.department?.name ?? "",
            callback: () => _setDepartment(context),
          ),
          item(
            title: appLocalizations.personnel,
            context: context,
            value: widget.user?.fullName ?? "",
            callback: () => _setPersonnel(context),
          ),
        ],
      ),
    );
  }

  _setDepartment(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetDepartmentWidget(
          department: widget.department,
          onChange: (value) => widget.setDepartment.call(value),
        );
      },
    );
  }

  _setPersonnel(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetPersonnelWidget(
          user: widget.user,
          onChange: (value) => widget.setUser.call(value),
        );
      },
    );
  }

  Widget item({
    required BuildContext context,
    required String title,
    required VoidCallback callback,
    required String value,
  }) {
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
            fontWeight: FontWeight.w600,
          ),
        ),
        InkWell(
          onTap: () => callback.call(),
          child: ContainerBorder(
            borderColors: colors.text.withOpacity(0.2),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down_sharp,
                  size: SpacingUnit.x7,
                  color: colors.text,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
