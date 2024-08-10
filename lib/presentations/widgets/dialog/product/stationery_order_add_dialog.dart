import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/domain/entities/reqisition/stationery/stationery.dart';
import 'package:base_app/gen/assets.gen.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class StationeryOderAddDialog extends StatefulWidget {
  const StationeryOderAddDialog(
      {super.key,
      this.requisitionStationery,
      this.stationery,
      required this.callBack,
      required this.callBackTypeContainer,
      this.checkTypeContainer = true});

  final ValueChanged<Stationeries>? requisitionStationery;
  final Stationeries? stationery;
  final VoidCallback callBack;
  final VoidCallback callBackTypeContainer;
  final bool checkTypeContainer;

  @override
  State<StationeryOderAddDialog> createState() => _StationeryOderAddDialogState();
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
  Stationery stationery = const Stationery(id: '', product: '', unitPrice: '0', unit: '');

  bool checkOnClick(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkProduct = product != '';
    final bool checkNumberOf = numberOf > 0;
    setState(() {
      errorProduct = checkProduct ? "" : appLocalizations.cannotBeLeftBlank;
      errorNumberOf = checkNumberOf ? "" : appLocalizations.quantityCannotBeZero;
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
    numberOfController.text = (widget.stationery?.quantity ?? 0).toString();
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
      borderColors: colors.text.withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.checkTypeContainer
                      ? ""
                      : product.isEmpty
                          ? appLocalizations.product
                          : product,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
                InkWell(
                  onTap: () => widget.callBackTypeContainer.call(),
                  child: SvgPicture.asset(
                    width: SpacingUnit.x6,
                    height: SpacingUnit.x6,
                    widget.checkTypeContainer
                        ? Assets.images.icon.home.chevronForward
                        : Assets.images.icon.activateIcon.drop,
                    colorFilter: ColorFilter.mode(colors.text.withOpacity(0.4), BlendMode.srcIn),
                  ),
                ),
              ],
            ),
            if (widget.checkTypeContainer)
              ItemAdd(
                title: appLocalizations.product,
                callback: () => _showBottomSheet(context),
                errorProduct: errorProduct,
              ),
            if (widget.checkTypeContainer)
              ItemAddStationeryDialog(
                check: true,
                onChangeProduct: (value) => setProduct(value, context),
                onchangeUnit: (value) => setUnit(value, context),
                onChangeUnitPrice: (value) => setUnitPrice(value, context),
                productController: productController,
                unitController: unitController,
                unitPriceController: unitPriceController,
              ),
            if (widget.checkTypeContainer)
              ItemCreateTotalMinute(
                error: errorNumberOf,
                title: appLocalizations.numberOf,
                totalMinuteController: numberOfController,
                onChange: (value) => _setNumber(value, context),
              ),
            if (widget.checkTypeContainer)
              ItemIntoMoney(
                title: appLocalizations.intoMoneyNoVAT,
                content: intoMoney.toInt().toString(),
              ),
            if (widget.checkTypeContainer)
              ItemCreateInput(
                title: appLocalizations.note,
                inputController: noteController,
                onChange: (value) => _setNote(value),
              ),
            if (widget.checkTypeContainer)
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: SpacingUnit.x4, horizontal: SpacingUnit.x1),
                child: AppButton(
                  title: appLocalizations.cancel,
                  onSubmit: () => widget.callBack.call(),
                  color: colors.text.withOpacity(0.4),
                ),
              )
          ],
        ),
      ),
    );
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
    });
    setAdd(context);
  }
}
