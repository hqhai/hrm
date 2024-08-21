import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_model_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/warehouse_releaseds.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/release_of_warehouse/list_product.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequestReleaseOfWarehousePageRoute = GoRoute(
    path: Pages.createRequestReleaseOfWarehousePage,
    name: Pages.createRequestReleaseOfWarehousePage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return CreateRequisitionReleaseOfWarehousePage(
        flowId: data['flowId'],
        requestId: data['requestId'],
      );
    });

class CreateRequisitionReleaseOfWarehousePage extends StatefulWidget {
  const CreateRequisitionReleaseOfWarehousePage({super.key, this.flowId, this.requestId = ''});

  final String? flowId;
  final String requestId;

  @override
  State<CreateRequisitionReleaseOfWarehousePage> createState() =>
      _CreateRequisitionReleaseOfWarehousePageState();
}

class _CreateRequisitionReleaseOfWarehousePageState
    extends State<CreateRequisitionReleaseOfWarehousePage> {
  List<WarehouseReleaseds> requisitionReleaseOfWarehouse = [];
  final TextEditingController scheduleController = TextEditingController();
  List<String> followers = [];
  String description = '', errorList = '', errorDescription = '', errorDialog = '';
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;
  bool checkClick = false;

  @override
  void initState() {
    if (widget.requestId.isNotEmpty) {
      final request = dI<RequisitionBloc>().state.requisition;
      description = request.config.description;
      scheduleController.text = request.config.description;
      followers = [...request.followerIds];
      requisitionReleaseOfWarehouse = [...request.config.warehourseReleaseds];
    }
    super.initState();
  }

  double opacity() {
    bool check = checkLoad == false && checkSuccess == false && checkUnSuccess == false;
    return check ? 1 : 0.3;
  }

  _listener(String errorCode) {
    setState(() {
      errorDialog = errorCode.isNotEmpty ? setErrorValue(errorCode) ?? errorCode : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
        title: Text(
          RequisitionTypeEnum.warehouseReleased.configTypeName,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
      body: BlocConsumer<RequisitionBloc, RequisitionState>(
        listener: (context, state) => _listener(state.errorCode),
        builder: (context, state) => BlocBuilder<UserByIdBloc, UserByIdState>(
          builder: (context, stateUserById) {
            return SingleChildScrollView(
              child: ContainerScreenMain(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ItemCreateInputArea(
                        requiredValidate: true,
                        error: errorDescription,
                        textController: scheduleController,
                        title: appLocalizations.reasonForRelease,
                        onChange: (value) => _setSchedule(value),
                      ),
                      ListProducts(
                        title: appLocalizations.stationeryList,
                        error: errorList,
                        listProducts: requisitionReleaseOfWarehouse,
                        onChangeList: (value) => _setList(value),
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
                          callbackSave: () => _save(context),
                          callbackCancel: () => _cancel(context),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
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

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    bool check = requisitionReleaseOfWarehouse.isNotEmpty && description != '';
    setState(() {
      errorDescription = description != '' ? "" : appLocalizations.cannotBeLeftBlank;
      errorList = requisitionReleaseOfWarehouse.isNotEmpty
          ? ''
          : appLocalizations.thereAreCurrentlyNoProducts;
    });
    return check;
  }

  setAdd(WarehouseReleaseds value) {
    setState(() {
      requisitionReleaseOfWarehouse.add(value);
    });
  }

  PostRequestRequest request() {
    return widget.requestId.isEmpty
        ? PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
              description: description,
              warehourseReleaseds: requisitionReleaseOfWarehouse,
            ),
          )
        : PostRequestRequest(
            id: widget.requestId,
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
              description: description,
              warehourseReleaseds: requisitionReleaseOfWarehouse,
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
      completerFail: () => completerFail(
        requestId: widget.requestId,
        errorDialog: errorDialog,
      ),
      completerSuccess: () => completerSuccess(
        requestId: widget.requestId,
        errorDialog: errorDialog,
      ),
    );
  }

  _cancel(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  _setFollower(List<User> value) {
    setState(() {
      followers = value.map((e) => e.id).toList();
    });
  }

  _setSchedule(String value) {
    setState(() {
      description = value;
    });
  }

  List<User> _setListUser(List<User> userById) {
    if (widget.requestId.isNotEmpty) {
      return userById;
    }
    return [];
  }

  _setList(List<WarehouseReleaseds> value) {
    setState(() {
      requisitionReleaseOfWarehouse = value;
    });
  }
}
