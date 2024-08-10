import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/warehouse_releaseds.dart';
import 'package:base_app/presentations/widgets/dialog/product/stationery_release_of_warehouse_dialog.dart';
import 'package:collection/collection.dart';
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
              onTap: () => _setAdd(),
              child: Icon(
                Icons.add,
                size: SpacingUnit.x8,
                color: colors.success,
              ),
            )
          ],
        ),
        Column(
          children: widget.listProducts
              .mapIndexed(
                (index, element) => ReleaseOfWarehouseAddDialog(
                  callBack: () => _delete(element, index),
                  releaseOfWarehouse: element,
                  requisitionReleaseOfWarehouse: (value) => _edit(value, index),
                ),
              )
              .toList(),
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

  _setAdd() {
    final listProduct = widget.listProducts;
    setState(() {
      listProduct.add(const WarehouseReleaseds());
      widget.onChangeList.call(listProduct);
    });
  }

  _edit(WarehouseReleaseds value, int index) {
    final listProduct = widget.listProducts;
    setState(() {
      listProduct[index] = value;
      widget.onChangeList.call(listProduct);
    });
  }

  _delete(WarehouseReleaseds element, int index) {
    final listProduct = widget.listProducts;
    setState(() {
      listProduct.removeAt(index);
      widget.onChangeList.call(listProduct);
    });
  }
}
