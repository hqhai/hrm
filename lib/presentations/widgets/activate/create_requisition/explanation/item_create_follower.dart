import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateFollower extends StatefulWidget {
  const ItemCreateFollower({
    super.key,
    this.onChange,
    this.title,
    this.listFollower = const [],
    this.error = '',
  });

  final String? title;
  final ValueChanged<List<User>>? onChange;
  final List<User> listFollower;
  final String error;

  @override
  State<ItemCreateFollower> createState() => _ItemCreateFollowerState();
}

class _ItemCreateFollowerState extends State<ItemCreateFollower> {
  List<User> listFollower = [];

  List<User> setListFollower() {
    if (widget.listFollower.isNotEmpty && listFollower.isEmpty) {
      setState(() {
        listFollower = widget.listFollower;
      });
      return widget.listFollower;
    } else if (widget.listFollower.isNotEmpty && listFollower.isNotEmpty) {
      return listFollower;
    }
    return listFollower;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title ?? "",
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: height * 0.08 * setListFollower().length,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: setListFollower().length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: width * 0.7,
                      height: height * 0.05,
                      padding: const EdgeInsets.all(SpacingUnit.x3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SpacingUnit.x2),
                        color: CustomsColor.colorBackground,
                        border: Border.all(
                          color: colors.text,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        setListFollower()[index].fullName,
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4),
                      ),
                    ),
                    GestureDetector(
                        onTap: () => _delete(index),
                        child: Icon(
                          Icons.delete,
                          color: colors.error,
                          size: SpacingUnit.x6,
                        ))
                  ],
                ),
              ),
            ),
          ),
          if (widget.error.isNotEmpty)
            Text(
              widget.error,
              style: TextStyle(
                color: colors.error,
                fontSize: SpacingUnit.x3,
              ),
            ),
          GestureDetector(
            onTap: () => _add(context),
            child: ContainerBorder(
              backgroundColors: colors.success,
              width: SpacingUnit.x20,
              padding: SpacingUnit.x1,
              borderColors: colors.success,
              child: Text(
                appLocalizations.add,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.background,
                  fontSize: SpacingUnit.x5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _add(BuildContext context) {
    setState(() {
      listFollower = [];
    });
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetWidget(
          onChange: (value) => setListPerson(value),
        );
      },
    );
  }

  _delete(int index) {
    setState(() {
      setState(() {
        listFollower.removeAt(index);
      });
    });
  }

  setListPerson(List<User> value) {
    setState(() {
      listFollower = value;
      widget.onChange?.call(listFollower);
    });
  }
}
