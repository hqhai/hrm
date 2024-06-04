import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateFollower extends StatefulWidget {
  const ItemCreateFollower({super.key, this.onChange, this.title});

  final String? title;
  final ValueChanged<String>? onChange;

  @override
  State<ItemCreateFollower> createState() => _ItemCreateFollowerState();
}

class _ItemCreateFollowerState extends State<ItemCreateFollower> {
  List<String> list = ['a', 'a1', 'a2', 'b', 'c', 'd'];

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: DropdownMenu<String>(
            width: width * 0.8,
            enableFilter: true,
            requestFocusOnTap: true,
            textStyle: const TextStyle(fontSize: SpacingUnit.x3),
            initialSelection: '',
            onSelected: (String? value) => _setFollower(value),
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
        ),
      ],
    );
  }

  _setFollower(String? value) {
    widget.onChange?.call(value ?? "");
  }
}
