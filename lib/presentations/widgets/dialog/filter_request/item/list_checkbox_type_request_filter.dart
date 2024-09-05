import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ListCheckboxTypeRequestFilter extends StatefulWidget {
  const ListCheckboxTypeRequestFilter({super.key, required this.onChange, required this.listTypes});

  final ValueChanged<List<RequisitionTypeEnum>> onChange;
  final List<RequisitionTypeEnum> listTypes;

  @override
  State<ListCheckboxTypeRequestFilter> createState() =>
      _ListCheckboxTypeRequestFilterState();
}

class _ListCheckboxTypeRequestFilterState
    extends State<ListCheckboxTypeRequestFilter> {
  List<RequisitionTypeEnum> listTypes = [];

  @override
  void initState() {
    listTypes = widget.listTypes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(SpacingUnit.x4),
          child: Text(
            appLocalizations.requestType,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: width * 0.75,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
            child: GridView.builder(
              //physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: SpacingUnit.x4,
                childAspectRatio: 4,
                crossAxisSpacing: SpacingUnit.x4,
              ),
              itemCount: RequisitionTypeEnum.values.length - 3,
              itemBuilder: (context, index) {
                final type = RequisitionTypeEnum.values[index];
                return GestureDetector(
                  onTap: () => setValue(index: index, type: type),
                  child: ContainerBorder(
                    paddingVertical: 0,
                    marginTop: 0,
                    backgroundColors: listTypes.contains(type)
                        ? colors.blue
                        : colors.background,
                    borderColors: colors.text.withOpacity(0.3),
                    child: Center(
                      child: Text(
                        type.configTypeNameFilter,
                        style: TextStyle(
                          color: listTypes.contains(type)
                              ? colors.background
                              : colors.text,
                          fontSize: SpacingUnit.x3,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  setValue({required int index, required RequisitionTypeEnum type}) {
    final check = !listTypes.contains(type);
    setState(() {
      if (check) {
        listTypes.add(type);
        widget.onChange.call(listTypes);
      } else {
        listTypes.remove(type);
        widget.onChange.call(listTypes);
      }
    });
  }
}
