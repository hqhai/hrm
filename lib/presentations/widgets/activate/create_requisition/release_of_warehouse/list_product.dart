import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/warehouse_releaseds.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/release_of_warehouse/item_list_release_of_warehouse.dart';
import 'package:base_app/presentations/widgets/dialog/product/stationery_release_of_warehouse_dialog.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ListProducts extends StatefulWidget {
  const ListProducts({
    super.key,
    required this.title,
    this.listProducts = const [],
    required this.onChangeList,
    this.error = '',
  });

  final String title, error;
  final List<WarehouseReleaseds> listProducts;
  final ValueChanged<List<WarehouseReleaseds>> onChangeList;

  @override
  State<ListProducts> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
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
          height: height * 0.14 * widget.listProducts.length,
          padding: const EdgeInsets.all(SpacingUnit.x1),
          margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
          ),
          child: ListView.builder(
            itemCount: widget.listProducts.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => _getStationeryInList(context, widget.listProducts[index], index),
              child: ItemListReleaseOfWarehouse(
               requisitionReleaseOfWarehouse: widget.listProducts[index],
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

  _getStationeryInList(
      BuildContext context, WarehouseReleaseds requisitionReleaseOfWarehouse, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ReleaseOfWarehouseAddDialog(
            releaseOfWarehouse: requisitionReleaseOfWarehouse,
            requisitionReleaseOfWarehouse: (value) => setEdit(value, index),
          ),
        );
      },
    );
  }

  setEdit(WarehouseReleaseds value, int index) {
    final listProducts = widget.listProducts;
    setState(() {
      listProducts[index] = WarehouseReleaseds(
          unit: value.unit,
          note: value.note,
          product: value.product,
          explain: value.explain,
          quantity: value.quantity);
      widget.onChangeList.call(listProducts);
    });
  }
}
