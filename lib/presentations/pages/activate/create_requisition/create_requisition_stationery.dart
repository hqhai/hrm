import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_request_model.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_list_stationery_order.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/stationery_order_add_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/success_or_unsuccess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequestStationeryOderPageRoute = GoRoute(
    path: Pages.createRequestStationeryOderPage,
    name: Pages.createRequestStationeryOderPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return CreateRequisitionStationeryOderPage(
        flowId: data['flowId'],
      );
    });

class CreateRequisitionStationeryOderPage extends StatefulWidget {
  const CreateRequisitionStationeryOderPage({super.key, this.flowId = ''});

  final String flowId;

  @override
  State<CreateRequisitionStationeryOderPage> createState() =>
      _CreateRequisitionStationeryOderPageState();
}

class _CreateRequisitionStationeryOderPageState extends State<CreateRequisitionStationeryOderPage> {
  List<Stationeries> listRequisitionStationery = [];
  List<String> followers = [];

  bool _checkValue() {
    bool check = listRequisitionStationery != [];
    return check;
  }

  _listener(BuildContext context, RequisitionState state) {
    if (state.status == RequisitionEnum.postRequisitionInit) {
      progressIndicatorDialog(context);
    } else if (state.status == RequisitionEnum.postRequisitionSuccess) {
      Navigator.of(context).pop();
      successDialog(context);
    } else if (state.status == RequisitionEnum.postRequisitionError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocListener<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(context, state),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            RequisitionTypeEnum.stationery.configTypeName,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x5,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height * 0.85,
            padding: const EdgeInsets.all(SpacingUnit.x3),
            margin: const EdgeInsets.all(SpacingUnit.x3),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
              border: Border.all(
                width: 1,
                color: colors.surface,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.stationeryList,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    width: width,
                    height: height * 0.14 * listRequisitionStationery.length,
                    padding: const EdgeInsets.all(SpacingUnit.x1),
                    margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
                    ),
                    child: ListView.builder(
                      itemCount: listRequisitionStationery.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () =>
                            _getStationeryInList(context, listRequisitionStationery[index], index),
                        child: ItemListStationery(
                          requisitionStationery: listRequisitionStationery[index],
                          index: index,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _addStationery(context),
                    child: Container(
                      alignment: Alignment.center,
                      height: SpacingUnit.x10,
                      padding: const EdgeInsets.all(SpacingUnit.x2),
                      decoration: BoxDecoration(
                        color: colors.outlineSuccess,
                        borderRadius: BorderRadius.circular(SpacingUnit.x1),
                        border: Border.all(
                          width: 1,
                          color: colors.text,
                        ),
                      ),
                      child: Text(
                        appLocalizations.moreOfficeProducts,
                        style: TextStyle(
                          fontSize: SpacingUnit.x3_5,
                          color: colors.background,
                        ),
                      ),
                    ),
                  ),
                  ItemCreateFollower(
                      title: appLocalizations.follower, onChange: (value) => _setFollower(value)),
                  Padding(
                    padding: const EdgeInsets.only(top: SpacingUnit.x3_5),
                    child: ItemButton(
                      callbackSave: () => _save(),
                      callbackCancel: () => _cancel(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _addStationery(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: StationeryOderAddDialog(
            requisitionStationery: (value) => setAdd(value),
          ),
        );
      },
    );
  }

  setAdd(Stationeries value) {
    setState(() {
      listRequisitionStationery.add(value);
    });
  }

  _save() {
    if (_checkValue()) {
      dI<RequisitionBloc>().add(
        PostRequestEvent(
          postRequestRequest: PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              stationeries: listRequisitionStationery,
            ),
          ),
        ),
      );
    }
  }

  _cancel() {}

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
    setState(() {
      listRequisitionStationery[index] = Stationeries(
        unit: value.unit,
        note: value.note,
        unitPrice: value.unitPrice,
        product: value.product,
        quantity: value.quantity,
        amount: value.amount,
      );
    });
  }

  _setFollower(List<User> value) {
    setState(() {
      followers = value.map((e) => e.id).toList();
    });
  }
}
