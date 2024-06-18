import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_request_model.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/postal_delivery/item_create_postal_delivery_type.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
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
      );
    });

class CreateRequisitionPostalDeliveryPage extends StatefulWidget {
  const CreateRequisitionPostalDeliveryPage({super.key, this.flowId});

  final String? flowId;

  @override
  State<CreateRequisitionPostalDeliveryPage> createState() =>
      _CreateRequisitionPostalDeliveryPageState();
}

class _CreateRequisitionPostalDeliveryPageState extends State<CreateRequisitionPostalDeliveryPage> {
  final TextEditingController reasonController = TextEditingController();
  String reason = '';
  List<String> followers = [];
  String errorDescription = '';
  RequisitionDeliveryTypeEnum? transferType = RequisitionDeliveryTypeEnum.rush;

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    bool check = reason != '';
    setState(() {
      errorDescription = reason != '' ? "" : appLocalizations.cannotBeLeftBlank;
    });
    return check;
  }

  _listener(BuildContext context, RequisitionState state) {
    if (state.status == RequisitionEnum.init) {
      progressIndicatorDialog(context);
    } else if (state.status == RequisitionEnum.success) {
      Navigator.of(context).pop();
      successDialog(context);
    } else if (state.status == RequisitionEnum.fail) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RequisitionTypeEnum.postalDelivery.configTypeName,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
      body: BlocListener<RequisitionBloc, RequisitionState>(
        listener: (context, state) => _listener(context, state),
        child: SingleChildScrollView(
          child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemCreateReasonTransferType(onChange: (value) => _setTransferType(value)),
                if (transferType == RequisitionDeliveryTypeEnum.rush)
                  Padding(
                    padding: const EdgeInsets.all(SpacingUnit.x3),
                    child: Text(appLocalizations.notePostalDelivery,
                        style: TextStyle(color: colors.error, fontSize: SpacingUnit.x3)),
                  ),
                ItemCreateInputArea(
                  error: errorDescription,
                  textController: reasonController,
                  title: appLocalizations.sendingPurpose,
                  onChange: (value) => _setReason(value),
                ),
                ItemCreateFollower(
                    title: appLocalizations.follower, onChange: (value) => _setFollower(value)),
                ItemButton(
                  callbackSave: () => _save(context),
                  callbackCancel: () => _cancel(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _setFollower(List<User> value) {
    setState(() {
      followers = value.map((e) => e.id).toList();
    });
  }

  _setReason(String value) {
    setState(() {
      reason = value;
    });
  }

  _save(BuildContext context) {
    if (_checkValue(context)) {
      dI<RequisitionBloc>().add(
        PostRequestEvent(
          postRequestRequest: PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              description: reason,
              deliveryType: transferType?.name ?? "",
            ),
          ),
        ),
      );
    }
  }

  _cancel() {}

  _setTransferType(RequisitionDeliveryTypeEnum value) {
    setState(() {
      transferType = value;
    });
  }
}
