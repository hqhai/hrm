import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/domain/entities/requisition/stationery/stationery.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_total_minute.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_add.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_dialog.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_into_money.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_stationery.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class StationeryOderAddDialog extends StatefulWidget {
  const StationeryOderAddDialog(
      {super.key,
      this.requisitionStationery,
      this.stationery,
      required this.callBack,
      this.checkTypeContainer = true});

  final ValueChanged<Stationeries>? requisitionStationery;
  final Stationeries? stationery;
  final VoidCallback callBack;
  final bool checkTypeContainer;

  @override
  State<StationeryOderAddDialog> createState() =>
      _StationeryOderAddDialogState();
}

class _StationeryOderAddDialogState extends State<StationeryOderAddDialog> {
  final TextEditingController productController = TextEditingController(),
      unitController = TextEditingController(),
      unitPriceController = TextEditingController(),
      numberOfController = TextEditingController(),
      noteController = TextEditingController();

  String note = '',
      unit = '',
      product = '',
      errorExplain = '',
      errorProduct = '',
      errorNumberOf = '';
  double intoMoney = 0, unitPrice = 0;
  int numberOf = 0;
  bool checkTypeContainer = true;
  Stationery stationery =
      const Stationery(id: '', product: '', unitPrice: '0', unit: '');

  bool checkOnClick(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkProduct = product != '';
    final bool checkNumberOf = numberOf > 0;
    setState(() {
      errorProduct = checkProduct ? "" : appLocalizations.cannotBeLeftBlank;
      errorNumberOf =
          checkNumberOf ? "" : appLocalizations.quantityCannotBeZero;
    });
    return checkProduct && checkNumberOf;
  }

  setStationery(Stationery value, BuildContext context) {
    setState(() {
      stationery = value;
      unitPrice = double.parse((value.unitPrice ?? '0').replaceAll(',', ''));
      product = value.product ?? "";
      unit = value.unit ?? "";
      productController.text = value.product ?? "";
      unitController.text = value.unit ?? "";
      unitPriceController.text = (value.unitPrice ?? '0').replaceAll(',', '');
      intoMoney = unitPrice * numberOf;
    });
    setAdd(context);
  }

  @override
  void initState() {
    productController.text = widget.stationery?.product ?? "";
    unitController.text = widget.stationery?.unit ?? "";
    unitPriceController.text = (widget.stationery?.unitPrice ?? 0).toString();
    numberOfController.text = (widget.stationery?.quantity ?? '').toString();
    noteController.text = widget.stationery?.note ?? "";
    product = widget.stationery?.product ?? "";
    unit = widget.stationery?.unit ?? "";
    note = widget.stationery?.note ?? "";
    numberOf = widget.stationery?.quantity ?? 0;
    unitPrice = widget.stationery?.unitPrice ?? 0;
    stationery = stationery.copyWith(unitPrice: unitPrice.toString());
    intoMoney = widget.stationery?.amount ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return ContainerBorder(
      borderColors: colors.text.withValues(alpha: 0.4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemAdd(
            checkTypeContainer: checkTypeContainer,
            title: checkTypeContainer
                ? appLocalizations.product
                : product.isEmpty
                    ? appLocalizations.product
                    : product,
            callback: () => setTypeContainer(),
          ),
          if (checkTypeContainer) ...[
            ItemAddStationeryDialog(
              type: RequisitionTypeEnum.stationery,
              check: true,
              onChangeProduct: (value) => setProduct(value, context),
              onchangeUnit: (value) => setUnit(value, context),
              onChangeUnitPrice: (value) => setUnitPrice(value, context),
              productController: productController,
              unitController: unitController,
              unitPriceController: unitPriceController,
              callBack: () => _showBottomSheet(context),
            ),
            ItemCreateTotalMinute(
              error: errorNumberOf,
              title: appLocalizations.numberOf,
              totalMinuteController: numberOfController,
              onChange: (value) => _setNumber(value, context),
            ),
            ItemIntoMoney(
              title: appLocalizations.intoMoneyNoVAT,
              content: intoMoney.toInt().toString(),
            ),
            ItemCreateInput(
              title: appLocalizations.note,
              inputController: noteController,
              onChange: (value) => _setNote(value),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: SpacingUnit.x4, horizontal: SpacingUnit.x1),
              child: AppButton(
                title: appLocalizations.cancel,
                onSubmit: () => _onSubmit(),
                color: colors.error.withValues(alpha: 0.7),
              ),
            )
          ]
        ],
      ),
    );
  }

  void _onSubmit() {
    if (numberOfController.text.isEmpty) {
      final appLocalizations = AppLocalizations.of(context)!;
      setState(() {
        errorNumberOf = appLocalizations.errorNumber;
      });
    }
    widget.callBack.call();
  }

  _setNote(String value) {
    setState(() {
      note = value;
    });
  }

  setAdd(BuildContext context) {
    if (checkOnClick(context)) {
      widget.requisitionStationery?.call(Stationeries(
          product: product,
          unitPrice: unitPrice,
          note: note,
          unit: unit,
          quantity: numberOf,
          amount: numberOf * unitPrice));
    }
  }

  _setNumber(String value, BuildContext context) {
    if (value.startsWith('0')) {
      numberOfController.text = value.substring(1);
    }
    setState(() {
      numberOf = value != '' ? int.parse(value) : 0;
      intoMoney = unitPrice * numberOf;
    });
    setAdd(context);
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetStationeryWidget(
          onChange: (value) => setStationery(value, context),
        );
      },
    );
  }

  setProduct(String value, BuildContext context) {
    setState(() {
      product = value;
    });
    setAdd(context);
  }

  setUnit(String value, BuildContext context) {
    setState(() {
      unit = value;
    });
    setAdd(context);
  }

  setUnitPrice(double value, BuildContext context) {
    setState(() {
      unitPrice = value;
      intoMoney = unitPrice * numberOf;
    });
    setAdd(context);
  }

  setTypeContainer() {
    setState(() {
      checkTypeContainer = !checkTypeContainer;
    });
  }
}
