import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
import 'package:base_app/common/utils/error_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_model_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_total_amount.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/list_stationeries.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/custom/month_picker.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
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
    this.requestId = '',
  });

  final String flowId;
  final String requestId;

  @override
  State<CreateRequisitionStationeryOderPage> createState() =>
      _CreateRequisitionStationeryOderPageState();
}

class _CreateRequisitionStationeryOderPageState extends State<CreateRequisitionStationeryOderPage> {
  List<Stationeries> listRequisitionStationery = [];
  List<String> followers = [];
  DateTime month = DateTime.now();
  String error = '', errorMonth = '', errorDialog = '';
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;
  bool checkClick = false;

  @override
  void initState() {
    if (widget.requestId.isNotEmpty) {
      final request = dI<RequisitionBloc>().state.requisition;
      followers = [...request.followerIds];
      listRequisitionStationery = [...request.config.stationeries];
      month = request.config.startDate ?? DateTime.now();
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

  double opacity() {
    bool check = checkLoad == false && checkSuccess == false && checkUnSuccess == false;
    return check ? 1 : 0.3;
  }

  _listener(String errorCode, BuildContext context) {
    setState(() {
      errorDialog = errorCode.isNotEmpty ? ErrorUtils.getErrorMessage(errorCode, context: context) : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(state.errorCode, context),
      builder: (context, state) => BlocBuilder<UserByIdBloc, UserByIdState>(
        builder: (context, stateUserById) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              iconTheme: IconThemeData(color: colors.text),
              title: Text(
                RequisitionTypeEnum.stationery.configTypeName,
                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
              ),
            ),
            body: SingleChildScrollView(
              child: ContainerScreenMain(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MonthPickerLoop(
                        requiredValidate: true,
                        title: appLocalizations.month,
                        oldDate: month,
                        onChange: (value) => setMonth(value),
                      ),
                      ListStationeries(
                        title: appLocalizations.stationeryList,
                        error: listRequisitionStationery.isNotEmpty ? '' : error,
                        listRequisitionStationery: listRequisitionStationery,
                        onChangeList: (value) => setList(value),
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
                      const ItemListStepFlow(),
                      Padding(
                        padding: const EdgeInsets.only(top: SpacingUnit.x3_5),
                        child: ItemButton(
                          id: widget.requestId,
                          callbackSave: () => _save(context),
                          callbackCancel: () => _cancel(context),
                        ),
                      )
                    ],
                  ),
                ),
              ),
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

  setAdd(Stationeries value) {
    setState(() {
      listRequisitionStationery.add(value);
    });
  }

  PostRequestRequest request() {
    return widget.requestId.isEmpty
        ? PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
              startDate: month,
              stationeries: listRequisitionStationery,
              subtotal: _subtotal(),
              numberValue: _numberValue(),
              totalAmount: _totalAmount(),
            ),
          )
        : PostRequestRequest(
            id: widget.requestId,
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
              startDate: month,
              stationeries: listRequisitionStationery,
              subtotal: _subtotal(),
              numberValue: _numberValue(),
              totalAmount: _totalAmount(),
            ),
          );
  }

  _save(BuildContext context) async {
    saveRequest(
      context: context,
      checkCreate: !checkClick && _checkValue(context) && widget.requestId.isEmpty,
      postRequestRequest: request(),
      checkEdit: !checkClick && _checkValue(context) && widget.requestId.isNotEmpty,
      checkLoadTrue: () => setCheckLoad(),
      completerFail: () => showToast(context: context, errorCode: errorDialog),
      completerSuccess: () => completerSuccess(
        requestId: widget.requestId,
        errorDialog: errorDialog,
      ),
    );
  }

  setMonth(DateTime value) {
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

  _cancel(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  _setFollower(List<User> value) {
    setState(() {
      followers = value.map((e) => e.id).toList();
    });
  }

  List<User> _setListUser(List<User> userById) {
    if (widget.requestId.isNotEmpty) {
      return userById;
    }
    return [];
  }

  setList(List<Stationeries> value) {
    setState(() {
      listRequisitionStationery = value;
    });
  }
}
