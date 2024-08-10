import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
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
    this.checkTypeContainer = const [],
    required this.changeTypeContainer,
  });

  final String title, error;
  final List<Stationeries> listRequisitionStationery;
  final ValueChanged<List<Stationeries>> onChangeList;
  final List<bool> checkTypeContainer;
  final ValueChanged<List<bool>> changeTypeContainer;

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
            Text(
              widget.title,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
                fontWeight: FontWeight.w800,
              ),
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
          padding: 0,
          borderColors: colors.background,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.listRequisitionStationery
                .mapIndexed(
                  (index, element) => StationeryOderAddDialog(
                    callBackTypeContainer: () => setTypeContainer(index),
                    checkTypeContainer: widget.checkTypeContainer[index],
                    callBack: () => _deleteStationery(index),
                    stationery: element,
                    requisitionStationery: (value) => setEdit(value, index),
                  ),
                )
                .toList(),
          ),
        ),
        if (widget.error != '')
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x1),
            child: Text(
              widget.error,
              style: TextStyle(
                color: colors.error,
                fontSize: SpacingUnit.x3,
              ),
            ),
          ),
      ],
    );
  }

  setTypeContainer(int index) {
    final listType = widget.checkTypeContainer;
    setState(() {
      listType[index] = !listType[index];
      widget.changeTypeContainer.call(listType);
    });
  }

  _addStationery(BuildContext context) {
    final stationery = widget.listRequisitionStationery;
    final types = widget.checkTypeContainer;
    setState(() {
      types.add(true);
      stationery.add(const Stationeries());
      widget.changeTypeContainer.call(types);
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
    final types = widget.checkTypeContainer;
    setState(() {
      types.removeAt(index);
      listRequisitionStationery.removeAt(index);
      widget.changeTypeContainer.call(types);
      widget.onChangeList.call(listRequisitionStationery);
    });
  }
}
