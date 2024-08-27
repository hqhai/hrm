import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:base_app/presentations/widgets/dialog/product/stationery_order_add_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ListStationeries extends StatefulWidget {
  const ListStationeries({
    super.key,
    required this.title,
    this.listRequisitionStationery = const [],
    required this.onChangeList,
    this.error = '',
  });

  final String title, error;
  final List<Stationeries> listRequisitionStationery;
  final ValueChanged<List<Stationeries>> onChangeList;

  @override
  State<ListStationeries> createState() => _ListStationeriesState();
}

class _ListStationeriesState extends State<ListStationeries> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TitleRequired(
              title: widget.title,
              requiredValidate: true,
            ),
            InkWell(
              onTap: () => _addStationery(context),
              child: Icon(
                Icons.add,
                size: SpacingUnit.x8,
                color: colors.success,
              ),
            )
          ],
        ),
        ContainerBorder(
          marginTop: 0,
          paddingVertical: 0,
          paddingHorizontal: 0,
          borderColors: colors.background,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.listRequisitionStationery
                .mapIndexed(
                  (index, element) => StationeryOderAddDialog(
                    callBack: () => _deleteStationery(index),
                    stationery: element,
                    requisitionStationery: (value) => setEdit(value, index),
                  ),
                )
                .toList(),
          ),
        ),
        if (widget.error != '')
          Text(
            widget.error,
            style: TextStyle(
              color: colors.error,
              fontSize: SpacingUnit.x3,
            ),
          ),
      ],
    );
  }

  _addStationery(BuildContext context) {
    final stationery = widget.listRequisitionStationery;
    setState(() {
      stationery.add(const Stationeries());
      widget.onChangeList.call(stationery);
    });
  }

  setEdit(Stationeries value, int index) {
    final listRequisitionStationery = widget.listRequisitionStationery;
    setState(() {
      listRequisitionStationery[index] = Stationeries(
        unit: value.unit,
        note: value.note,
        unitPrice: value.unitPrice,
        product: value.product,
        quantity: value.quantity,
        amount: value.amount,
      );
      widget.onChangeList.call(listRequisitionStationery);
    });
  }

  _deleteStationery(int index) {
    final listRequisitionStationery = widget.listRequisitionStationery;
    setState(() {
      listRequisitionStationery.removeAt(index);
      widget.onChangeList.call(listRequisitionStationery);
    });
  }
}
