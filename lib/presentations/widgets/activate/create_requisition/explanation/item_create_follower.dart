import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateFollower extends StatefulWidget {
  const ItemCreateFollower({super.key, this.onChange, this.title});

  final String? title;
  final ValueChanged<List<String>>? onChange;

  @override
  State<ItemCreateFollower> createState() => _ItemCreateFollowerState();
}

class _ItemCreateFollowerState extends State<ItemCreateFollower> {
  List<String> list = ['a', 'a1', 'a2', 'b', 'c', 'd'];
  List<String> listFollower = [''];

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
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
          height: height * 0.1 * listFollower.length,
          child: ListView.builder(
            itemCount: listFollower.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DropdownMenu<String>(
                    width: width * 0.5,
                    enableFilter: true,
                    requestFocusOnTap: true,
                    textStyle: const TextStyle(fontSize: SpacingUnit.x3),
                    initialSelection: '',
                    onSelected: (String? value) => _setFollower(value, index),
                    menuHeight: SpacingUnit.x50,
                    dropdownMenuEntries: list
                        .map(
                          (value) => DropdownMenuEntry<String>(
                            value: value,
                            label: value,
                          ),
                        )
                        .toList(),
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
          onPressed: () => _add(),
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
    );
  }

  _setFollower(String? value, int index) {
    setState(() {
      listFollower[index] = value ?? "";
      widget.onChange?.call(listFollower);
    });
  }

  _add() {
    setState(() {
      listFollower.add('');
    });
  }

  _delete(int index) {
    setState(() {
      setState(() {
        listFollower.removeAt(index);
      });
    });
  }
}
