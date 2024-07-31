import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ListCheckboxTypeRequestFilter extends StatefulWidget {
  const ListCheckboxTypeRequestFilter({super.key, required this.onChange});

  final ValueChanged<List<RequisitionTypeEnum>> onChange;

  @override
  State<ListCheckboxTypeRequestFilter> createState() => _ListCheckboxTypeRequestFilterState();
}

class _ListCheckboxTypeRequestFilterState extends State<ListCheckboxTypeRequestFilter> {
  List<bool> listCheck = [];
  List<RequisitionTypeEnum> listTypes = [];

  @override
  void initState() {
    listCheck = List.filled(RequisitionTypeEnum.values.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Column(
      children: [
        Text(
          appLocalizations.type,
          style: TextStyle(
              color: colors.text, fontSize: SpacingUnit.x3_5, fontWeight: FontWeight.w400),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: RequisitionTypeEnum.values
                    .where((e) => e != RequisitionTypeEnum.core)
                    .mapIndexed(
                      (index, element) => Column(
                        children: [
                          CheckboxListTile(
                            value: listCheck[index],
                            onChanged: (value) =>
                                setValue(index: index, value: value, type: element),
                            subtitle: Text(
                              element.configTypeName,
                              style: TextStyle(
                                  color: colors.text,
                                  fontSize: SpacingUnit.x3_5,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Divider(
                            height: SpacingUnit.x0_25,
                            color: colors.outline.withOpacity(0.2),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  setValue({required int index, bool? value, required RequisitionTypeEnum type}) {
    setState(() {
      listCheck[index] = value ?? false;
      if (value == true) {
        listTypes.add(type);
        widget.onChange.call(listTypes);
      } else {
        listTypes.remove(type);
        widget.onChange.call(listTypes);
      }
    });
  }
}
