import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateFollower extends StatefulWidget {
  const ItemCreateFollower({super.key, this.onChange, this.title});

  final String? title;
  final ValueChanged<List<User>>? onChange;

  @override
  State<ItemCreateFollower> createState() => _ItemCreateFollowerState();
}

class _ItemCreateFollowerState extends State<ItemCreateFollower> {
  List<User> listFollower = [];

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
            height: height * 0.08 * listFollower.length,
            child: ListView.builder(
              itemCount: listFollower.length,
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
                        listFollower[index].fullName ?? "",
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
          ElevatedButton(
            onPressed: () => _add(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.blue,
            ),
            child: Text(
              appLocalizations.add,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x5,
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
