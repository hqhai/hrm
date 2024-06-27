import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_request_model.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_month_input.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_list_stationery_order.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_total_amount.dart';
import 'package:base_app/presentations/widgets/custom/app_button_add_list.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/product/stationery_order_add_dialog.dart';
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
        requestId: data['requestId'],
      );
    });

class CreateRequisitionStationeryOderPage extends StatefulWidget {
  const CreateRequisitionStationeryOderPage({
    super.key,
    this.flowId = '',
    this.requestId,
  });

  final String flowId;
  final String? requestId;

  @override
  State<CreateRequisitionStationeryOderPage> createState() =>
      _CreateRequisitionStationeryOderPageState();
}

class _CreateRequisitionStationeryOderPageState extends State<CreateRequisitionStationeryOderPage> {
  List<Stationeries> listRequisitionStationery = [];
  List<String> followers = [];
  String month = "1";
  String error = '', errorMonth = '';
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;
  final TextEditingController inputController = TextEditingController(text: '1');

  @override
  void initState() {
    if (widget.requestId?.isNotEmpty ?? false) {
      dI<RequisitionBloc>().add(
        GetRequisitionByIdEvent(id: widget.requestId),
      );
    }
    super.initState();
  }

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool check = listRequisitionStationery.isNotEmpty;
    setState(() {
      error = check ? '' : appLocalizations.thereAreCurrentlyNoProducts;
    });
    return check;
  }

  _listener(BuildContext context, RequisitionState state) {
    if (state.statusGetById == RequisitionEnum.success && widget.requestId != null) {
      setState(() {
        followers = state.requisition.followerIds;
        listRequisitionStationery = [...?state.requisition.config.stationeries];
        month = state.requisition.config.description ?? "";
        inputController.text = month;
        dI<UserByIdBloc>().add(GetUsersByIdEvent(ids: state.requisition.followerIds));
      });
    }
  }

  bool _listenWhen(RequisitionState statusP, RequisitionState statusC) {
    return statusP.requisition != statusC.requisition;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(context, state),
      listenWhen: (previous, current) => _listenWhen(previous, current),
      builder: (context, state) => BlocBuilder<UserByIdBloc, UserByIdState>(
        builder: (context, stateUserById) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                RequisitionTypeEnum.stationery.configTypeName,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x5,
                ),
              ),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
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
                          ItemMonthInput(
                            title: appLocalizations.month,
                            error: errorMonth,
                            inputController: inputController,
                            onChange: (value) => setMonth(value),
                          ),
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
                                onTap: () => _getStationeryInList(
                                    context, listRequisitionStationery[index], index),
                                child: ItemListStationery(
                                  requisitionStationery: listRequisitionStationery[index],
                                  index: index,
                                ),
                              ),
                            ),
                          ),
                          if (error != '')
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x1),
                              child: Text(
                                error,
                                style: TextStyle(
                                  color: colors.error,
                                  fontSize: SpacingUnit.x3,
                                ),
                              ),
                            ),
                          ButtonAddList(
                            title: appLocalizations.moreOfficeProducts,
                            callBack: () => _addStationery(context),
                          ),
                          ItemTotalAmount(
                            totalAmount: _totalAmount(),
                          ),
                          ItemCreateFollower(
                              listFollower: _setListUser(
                                stateUserById.userById,
                              ),
                              title: appLocalizations.follower,
                              onChange: (value) => _setFollower(value)),
                          Padding(
                            padding: const EdgeInsets.only(top: SpacingUnit.x3_5),
                            child: ItemButton(
                              callbackSave: () => _save(context),
                              callbackCancel: () => _cancel(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                CheckLoadDialog(
                  fail: setErrorValue(state.errorCode),
                  checkLoad: checkLoad,
                  checkSuccess: checkSuccess,
                  checkUnSuccess: checkUnSuccess,
                  checkSuccessChange: () => setCheckSuccess(),
                  checkUnSuccessChange: () => setCheckUnSuccess(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  setCheckSuccess() {
    setState(() {
      checkSuccess = false;
    });
  }

  setCheckUnSuccess() {
    setState(() {
      checkUnSuccess = false;
    });
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

  _save(BuildContext context) async {
    if (_checkValue(context) && widget.requestId != null) {
      Completer completer = Completer<RequisitionEnum>();
      dI<RequisitionBloc>().add(
        EditRequestEvent(
          completer: completer,
          postRequestRequest: PostRequestRequest(
            id: widget.requestId,
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              description: month,
              stationeries: listRequisitionStationery,
              subtotal: _subtotal(),
              numberValue: _numberValue(),
              totalAmount: _totalAmount(),
            ),
          ),
        ),
      );
      final status = await completer.future;
      if (status == RequisitionEnum.success) {
        setState(() {
          checkLoad = false;
          checkSuccess = true;
        });
      }
      if (status == RequisitionEnum.fail) {
        setState(() {
          checkLoad = false;
          checkUnSuccess = true;
        });
      }
    } else if (_checkValue(context)) {
      setState(() {
        checkLoad = true;
      });
      Completer completer = Completer<RequisitionEnum>();
      dI<RequisitionBloc>().add(
        PostRequestEvent(
          completer: completer,
          postRequestRequest: PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              description: month,
              stationeries: listRequisitionStationery,
              subtotal: _subtotal(),
              numberValue: _numberValue(),
              totalAmount: _totalAmount(),
            ),
          ),
        ),
      );
      final status = await completer.future;
      if (status == RequisitionEnum.success) {
        setState(() {
          checkLoad = false;
          checkSuccess = true;
        });
      }
      if (status == RequisitionEnum.fail) {
        setState(() {
          checkLoad = false;
          checkUnSuccess = true;
        });
      }
    }
  }

  setMonth(String value) {
    setState(() {
      month = value;
    });
  }

  double _subtotal() {
    double subtotal = 0;
    for (var element in listRequisitionStationery) {
      subtotal += element.amount ?? 0;
    }
    return subtotal;
  }

  double _numberValue() {
    return _subtotal() * 0.08;
  }

  double _totalAmount() {
    return _subtotal() + _numberValue();
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

  List<User> _setListUser(List<User> userById) {
    if (widget.requestId != null) {
      return userById;
    }
    return [];
  }
}
