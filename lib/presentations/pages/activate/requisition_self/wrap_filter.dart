import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class WrapFilter extends StatefulWidget {
  const WrapFilter({super.key, this.listFilter = const [], required this.onChange,});
  final List<StatusRequestEnum> listFilter;
  final ValueChanged<StatusRequestEnum> onChange;

  @override
  State<WrapFilter> createState() => _WrapFilterState();
}

class _WrapFilterState extends State<WrapFilter> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: SpacingUnit.x4,
      runSpacing: SpacingUnit.x3,
      children: widget.listFilter
          .map(
            (e) => GestureDetector(
          onTap: () => removeListFilter(e),
          child: Container(
            padding: const EdgeInsets.all(
              SpacingUnit.x1,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                SpacingUnit.x1,
              ),
              color: colors.background,
              border: Border.all(
                color: colors.text,
                width: SpacingUnit.x0_25,
              ),
            ),
            child: Row(
              children: [
                Text(
                  e.configRequestStatusName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: colors.text, fontSize: SpacingUnit.x3),
                ),
                const SizedBox(
                  width: SpacingUnit.x1,
                ),
                GestureDetector(
                  onTap: () => removeListFilter(e),
                  child: Icon(
                    Icons.cancel_outlined,
                    size: SpacingUnit.x5,
                    color: colors.error,
                  ),
                )
              ],
            ),
          ),
        ),
      )
          .toList(),
    );
  }

  removeListFilter(StatusRequestEnum e) {
    widget.onChange.call(e);
  }
}
