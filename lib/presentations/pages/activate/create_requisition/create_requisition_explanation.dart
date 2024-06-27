import 'dart:async';
import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_request_model.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_time.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_reason_for_explanation.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

final createRequestExplanationPageRoute = GoRoute(
  path: Pages.createRequestExplanationPage,
  name: Pages.createRequestExplanationPage,
  builder: (context, GoRouterState state) {
    Map data = state.extra as Map;
    return CreateRequisitionExplanationPage(
      flowId: data['flowId'],
      requestId: data['requestId'],
      type: data['type'],
    );
  },
);

class CreateRequisitionExplanationPage extends StatefulWidget {
  const CreateRequisitionExplanationPage({
    super.key,
    this.flowId = '',
    this.requestId,
    this.type = RequisitionTypeEnum.explanation,
  });

  final RequisitionTypeEnum type;
  final String flowId;
  final String? requestId;

  @override
  State<CreateRequisitionExplanationPage> createState() => _CreateRequisitionExplanationPageState();
}

class _CreateRequisitionExplanationPageState extends State<CreateRequisitionExplanationPage> {
  final TextEditingController totalMinuteController = TextEditingController(),
      reasonController = TextEditingController(),
      detailedDescriptionController = TextEditingController(),
      applicationCodeController = TextEditingController();
  int totalMinute = 0;
  String errorReason = '', errorContent = '', errorVehicle = '', errorDestination = '';
  String reason = '', detailedDescription = '', replaceDate = '', workDate = '';
  List<String> followers = [];
  List<File> files = [];
  RequisitionTypeExplanationEnum? reasonForExplanation = RequisitionTypeExplanationEnum.late;

  @override
  void initState() {
    if (widget.requestId?.isNotEmpty ?? false) {
      dI<RequisitionBloc>().add(
        GetRequisitionByIdEvent(id: widget.requestId),
      );
    }
    super.initState();
  }

  _listener(BuildContext context, RequisitionState state) {}

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocListener<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(context, state),
      listenWhen: (previous, current) => _listenWhen(previous, current),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.type.configTypeName,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x5,
            ),
          ),
        ),
        body: SingleChildScrollView(
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
                ItemCreateInputArea(
                  error: errorReason,
                  textController: reasonController,
                  title: appLocalizations.reason,
                  onChange: (value) => _setReason(value),
                ),
                ItemCreateInputArea(
                  error: errorDestination,
                  textController: detailedDescriptionController,
                  title: appLocalizations.detailedDescription,
                  onChange: (value) => _setDetailedDescription(value),
                ),
                ItemCreateTime(
                  check: true,
                  title: appLocalizations.workDay,
                  dateOfBirth: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                  onChangeDateOfBirth: (value) => _setWorkDate(value),
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

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    bool check = reason != '' && detailedDescription != '';
    setState(() {
      errorReason = reason != '' ? '' : appLocalizations.cannotBeLeftBlank;
      errorDestination = detailedDescription != '' ? '' : appLocalizations.cannotBeLeftBlank;
    });
    return check;
  }

  _setReasonForExplanation(RequisitionTypeExplanationEnum? value) {
    setState(() {
      reasonForExplanation = value;
    });
  }

  _setFollower(List<User> value) {
    setState(() {
      followers = value.map((e) => e.id).toList();
    });
  }

  /*_setTotalMinute(String value) {
    setState(() {
      totalMinute = value as int;
    });
  }*/

  _setReason(String value) {
    setState(() {
      reason = value;
    });
  }

  _setDetailedDescription(String value) {
    setState(() {
      detailedDescription = value;
    });
  }

  _setDate(String value) {
    setState(() {
      replaceDate = formatIso8601(value);
    });
  }

  _save(BuildContext context) async {
    if (_checkValue(context)) {
      progressIndicatorDialog(context);
      Completer completer = Completer<RequisitionEnum>();
      dI<RequisitionBloc>().add(
        PostRequestEvent(
          completer: completer,
          postRequestRequest: PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              explanationReason: reasonForExplanation?.name,
              startDate: workDate,
              destination: detailedDescription,
              endDate: replaceDate,
            ),
          ),
        ),
      );
      final status = await completer.future;
      if (status == RequisitionEnum.success) {
        if (!context.mounted) return;
        Navigator.of(context).pop();
        successDialog(context);
      }
      if (status == RequisitionEnum.fail) {
        if (!context.mounted) return;
        Navigator.of(context).pop();
        unsuccessfulDialog(context);
      }
    }
  }

  _cancel() {}

  _setWorkDate(String value) {
    setState(() {
      workDate = formatIso8601(value);
    });
  }

  _listenWhen(RequisitionState previous, RequisitionState current) {
    return previous != current;
  }
}
