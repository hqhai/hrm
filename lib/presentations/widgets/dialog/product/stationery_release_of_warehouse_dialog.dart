import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/warehouse_releaseds.dart';
import 'package:base_app/domain/entities/reqisition/stationery/stationery.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_total_minute.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_add.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_dialog.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_stationery.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ReleaseOfWarehouseAddDialog extends StatefulWidget {
  const ReleaseOfWarehouseAddDialog(
      {super.key,
      this.requisitionReleaseOfWarehouse,
      this.releaseOfWarehouse,
      required this.callBack});

  final ValueChanged<WarehouseReleaseds>? requisitionReleaseOfWarehouse;
  final WarehouseReleaseds? releaseOfWarehouse;
  final VoidCallback callBack;

  @override
  State<ReleaseOfWarehouseAddDialog> createState() => _ReleaseOfWarehouseAddDialogState();
}

class _ReleaseOfWarehouseAddDialogState extends State<ReleaseOfWarehouseAddDialog> {
  final TextEditingController productController = TextEditingController(),
      unitController = TextEditingController(),
      explainController = TextEditingController(),
      numberOfController = TextEditingController(),
      noteController = TextEditingController();
  String explain = '',
      note = '',
      product = '',
      unit = '',
      errorProduct = '',
      errorNumberOf = '',
      errorExplain = '';
  int numberOf = 0;
  Stationery stationery = const Stationery(id: '', product: '', unitPrice: '0', unit: '');

  @override
  void initState() {
    unitController.text = widget.releaseOfWarehouse?.unit ?? '';
    productController.text = widget.releaseOfWarehouse?.product ?? "";
    explainController.text = widget.releaseOfWarehouse?.explain ?? "";
    numberOfController.text = (widget.releaseOfWarehouse?.quantity ?? 0).toString();
    noteController.text = widget.releaseOfWarehouse?.note ?? "";
    product = widget.releaseOfWarehouse?.product ?? "";
    explain = widget.releaseOfWarehouse?.explain ?? "";
    note = widget.releaseOfWarehouse?.note ?? "";
    unit = widget.releaseOfWarehouse?.unit ?? '';
    numberOf = widget.releaseOfWarehouse?.quantity ?? 0;
    super.initState();
  }

  bool checkOnClick(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkProduct = product != '';
    final bool checkNumberOf = numberOf > 0;
    final bool checkExplain = explain.isNotEmpty;
    setState(() {
      errorProduct = checkProduct ? "" : appLocalizations.cannotBeLeftBlank;
      errorNumberOf = checkNumberOf ? "" : appLocalizations.quantityCannotBeZero;
      errorExplain = checkExplain ? "" : appLocalizations.cannotBeLeftBlank;
    });
    return checkProduct && checkNumberOf && checkExplain;
  }

  setStationery(Stationery value) {
    setState(() {
      stationery = value;
      product = value.product ?? "";
      unit = value.unit ?? "";
      productController.text = value.product ?? "";
      unitController.text = value.unit ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return ContainerBorder(
      padding: SpacingUnit.x4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => widget.callBack.call(),
              child: Icon(
                Icons.close,
                size: SpacingUnit.x8,
                color: colors.error,
              ),
            ),
          ),
          ItemAdd(
            callback: () => _showBottomSheet(context),
            title: appLocalizations.product,
            errorProduct: errorProduct,
          ),
          ItemAddStationeryDialog(
            check: false,
            onChangeProduct: (value) => setProduct(value, context),
            onchangeUnit: (value) => setUnit(value, context),
            productController: productController,
            unitController: unitController,
          ),
          ItemCreateInput(
            error: errorExplain,
            title: appLocalizations.explain,
            inputController: explainController,
            onChange: (value) => _setExplain(value, context),
          ),
          ItemCreateTotalMinute(
            error: errorNumberOf,
            title: appLocalizations.numberOf,
            totalMinuteController: numberOfController,
            onChange: (value) => _setNumber(value, context),
          ),
          ItemCreateInputArea(
            textController: noteController,
            title: appLocalizations.note,
            onChange: (value) => _setNote(value, context),
          ),
        ],
      ),
    );
  }

  _setExplain(String value, BuildContext context) {
    setState(() {
      explain = value;
    });
    checkOnClick(context);
    setAdd(context);
  }

  _setNote(String value, BuildContext context) {
    setState(() {
      note = value;
    });
    checkOnClick(context);
    setAdd(context);
  }

  setAdd(BuildContext context) {
    widget.requisitionReleaseOfWarehouse?.call(WarehouseReleaseds(
      product: product,
      note: note,
      unit: unit,
      quantity: numberOf,
      explain: explain,
    ));
  }

  _setNumber(String value, BuildContext context) {
    setState(() {
      numberOf = value != '' ? int.parse(value) : 0;
    });
    checkOnClick(context);
    setAdd(context);
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetStationeryWidget(
          onChange: (value) => setStationery(value),
        );
      },
    );
  }

  setProduct(String value, BuildContext context) {
    setState(() {
      product = value;
    });
    checkOnClick(context);
    setAdd(context);
  }

  setUnit(String value, BuildContext context) {
    setState(() {
      unit = value;
    });
    checkOnClick(context);
    setAdd(context);
  }
}
