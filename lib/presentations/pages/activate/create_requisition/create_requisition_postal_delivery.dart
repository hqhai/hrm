
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_model_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/postal_delivery/item_create_postal_delivery_type.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequestPostalDeliveryPageRoute = GoRoute(
    path: Pages.createRequestPostalDeliveryPage,
    name: Pages.createRequestPostalDeliveryPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return CreateRequisitionPostalDeliveryPage(
        flowId: data['flowId'],
        requestId: data['requestId'],
      );
    });

class CreateRequisitionPostalDeliveryPage extends StatefulWidget {
  const CreateRequisitionPostalDeliveryPage({super.key, this.flowId, this.requestId =''});

  final String? flowId;
  final String requestId;

  @override
  State<CreateRequisitionPostalDeliveryPage> createState() =>
      _CreateRequisitionPostalDeliveryPageState();
}

class _CreateRequisitionPostalDeliveryPageState extends State<CreateRequisitionPostalDeliveryPage> {
  final TextEditingController reasonController = TextEditingController();
  List<String> followers = [];
  String errorDescription = '', errorDialog = '', reason = '';
  RequisitionDeliveryTypeEnum transferType = RequisitionDeliveryTypeEnum.express;
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;
  bool checkClick = false;

  @override
  void initState() {
    if (widget.requestId.isNotEmpty) {
      final request = dI<RequisitionBloc>().state.requisition;
      reason = request.config.description;
      transferType = convertDeliveryType(request.config.deliveryType)??RequisitionDeliveryTypeEnum.express;
      reasonController.text = request.config.description;
      followers = [...request.followerIds];
    }
    super.initState();
  }

  double opacity(){
    bool check = checkLoad == false && checkSuccess == false && checkUnSuccess == false;
    return check ? 1 : 0.3;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
        title: Text(
          RequisitionTypeEnum.postalDelivery.configTypeName,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
      body: BlocBuilder<RequisitionBloc, RequisitionState>(
        builder: (context, state) => BlocBuilder<UserByIdBloc, UserByIdState>(
          builder: (context, stateUserById) {
            return SingleChildScrollView(
              child: ContainerScreenMain(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemCreateReasonTransferType(
                      onChange: (value) => _setTransferType(value),
                      typeDefault: transferType,
                    ),
                    if (transferType == RequisitionDeliveryTypeEnum.express)
                      Padding(
                        padding: const EdgeInsets.only(bottom: SpacingUnit.x3),
                        child: Text('',
                            style: TextStyle(color: colors.error, fontSize: SpacingUnit.x3)),
                      ),
                    ItemCreateInputArea(
                      error: errorDescription,
                      textController: reasonController,
                      title: appLocalizations.sendingPurpose,
                      onChange: (value) => _setReason(value),
                    ),
                    ItemCreateFollower(
                        listFollower: _setListUser(
                          stateUserById.userById,
                        ),
                        title: appLocalizations.follower,
                        onChange: (value) => _setFollower(value)),
                    const ItemListStepFlow(),
                    ItemButton(
                      callbackSave: () => _save(context),
                      callbackCancel: () => _cancel(context),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<User> _setListUser(List<User> userById) {
    if (widget.requestId.isNotEmpty) {
      return userById;
    }
    return [];
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

  _setFollower(List<User> value) {
    setState(() {
      followers = value.map((e) => e.id).toList();
    });
  }

  RequisitionDeliveryTypeEnum? convertDeliveryType(String type) {
    if (type != '') {
      return RequisitionDeliveryTypeEnum.values.firstWhere((element) => element.name == type);
    }
    return null;
  }

  _setReason(String value) {
    setState(() {
      reason = value;
    });
  }

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    bool check = reason != '';
    setState(() {
      errorDescription = reason != '' ? "" : appLocalizations.cannotBeLeftBlank;
    });
    return check;
  }

  PostRequestRequest request() {
    return widget.requestId.isEmpty
        ? PostRequestRequest(
      followerIds: followers,
      flowId: widget.flowId,
      config: ConfigModelRequest(
        description: reason,
        deliveryType: transferType.name,
      ),
    )
        : PostRequestRequest(
      id: widget.requestId,
      followerIds: followers,
      flowId: widget.flowId,
      config: ConfigModelRequest(
        description: reason,
        deliveryType: transferType.name,
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
    );
  }

  _cancel(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  _setTransferType(RequisitionDeliveryTypeEnum value) {
    setState(() {
      transferType = value;
    });
  }
}
