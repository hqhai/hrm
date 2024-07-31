import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_list_stationery_order.dart';
import 'package:base_app/presentations/widgets/dialog/product/stationery_order_add_dialog.dart';
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w800,
          ),
        ),
        Container(
          width: width,
          height: height * 0.14 * widget.listRequisitionStationery.length,
          padding: const EdgeInsets.all(SpacingUnit.x1),
          margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
          ),
          child: ListView.builder(
            itemCount: widget.listRequisitionStationery.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => _getStationeryInList(context, widget.listRequisitionStationery[index], index),
              child: ItemListStationery(
                requisitionStationery: widget.listRequisitionStationery[index],
                index: index,
              ),
            ),
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

  _getStationeryInList(BuildContext context, Stationeries listRequisitionStationery, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: StationeryOderAddDialog(
            stationery: listRequisitionStationery,
            requisitionStationery: (value) => setEdit(value, index),
          ),
        );
      },
    );
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
}
