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
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_load_flie.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create_interval_on_leave.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create_take_leave.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequestLeavePageRoute = GoRoute(
    path: Pages.createRequestLeavePage,
    name: Pages.createRequestLeavePage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return CreateRequisitionLeavePage(
        flowId: data['flowId'],
        requestId: data['requestId'],
        type: data['type'],
      );
    });

class CreateRequisitionLeavePage extends StatefulWidget {
  const CreateRequisitionLeavePage({
    super.key,
    this.flowId = '',
    this.requestId,
    this.type = RequisitionTypeEnum.yearlyAndSeniorityLeave,
  });

  final RequisitionTypeEnum type;
  final String flowId;
  final String? requestId;

  @override
  State<CreateRequisitionLeavePage> createState() => _CreateRequisitionLeavePageState();
}

class _CreateRequisitionLeavePageState extends State<CreateRequisitionLeavePage> {
  final TextEditingController detailedDescriptionController = TextEditingController(),
      detailedReasonController = TextEditingController();
  int totalMinute = 0;
  String? startTime, endTime, description, detailedDescription, detailedReason;
  EnumTakeLeave? reason;
  List<File> files = [];
  List<String> followers = [], substitutes = [];
  RequisitionTypeEnum? reasonForOnLeave = RequisitionTypeEnum.yearlyAndSeniorityLeave;

  @override
  void initState() {
    reasonForOnLeave = widget.type;
    reason = listEnumTakeLeave();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
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
              width: SpacingUnit.x0_25,
              color: colors.surface,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemCreateIntervalOnLeave(
                //total: ,
                error: '',
                startTimeOld: startTime,
                endTimeOld: endTime,
                dayOrHours: true,
                title: appLocalizations.intervalOnLeave,
                startTime: (value) => setStartTime(value),
                endTime: (value) => setEndTime(value),
              ),
              ItemTakeLeave(
                type: widget.type,
                onChange: (value) => _setReason(value),
              ),
              if (_checkType())
                ItemCreateInputArea(
                  error: '',
                  textController: detailedReasonController,
                  title: appLocalizations.detailedReason,
                  onChange: (value) => _setDetailedReason(value),
                ),
              ItemCreateFollower(
                title: appLocalizations.substitute,
                onChange: (value) => _setSubstitute(value),
              ),
              ItemCreateFollower(
                title: appLocalizations.follower,
                onChange: (value) => _setFollower(value),
              ),
              ItemCreateInputArea(
                textController: detailedDescriptionController,
                title: appLocalizations.detailedDescription,
                onChange: (value) => _setDescription(value),
              ),
              ItemLoadFile(
                onChangeFiles: (value) => _setFile(value),
              ),
              ItemButton(
                callbackSave: () => _save(context),
                callbackCancel: () => _cancel(),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _checkType() {
    return reasonForOnLeave == RequisitionTypeEnum.yearlyAndSeniorityLeave ||
        reasonForOnLeave == RequisitionTypeEnum.compensatoryLeave ||
        reasonForOnLeave == RequisitionTypeEnum.otherLeave;
  }

  _setFollower(List<User> value) {
    setState(() {
      followers = value.map((e) => e.id).toList();
    });
  }

  _setDescription(String value) {
    setState(() {
      description = value;
    });
  }

  _setFile(List<File> value) {
    setState(() {
      files = value;
    });
  }

  _save(BuildContext context) {
    if (_checkValue(context) && widget.requestId == null) {
      Completer completer = Completer<RequisitionEnum>();
      dI<RequisitionBloc>().add(
        PostRequestEvent(
          files: files,
          postRequestRequest: PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              takeLeaveReason: reason?.name,
              description: detailedDescriptionController.text,
              subtitudePersons: substitutes,
              endDate: formatIso8601(endTime),
              startDate: formatIso8601(startTime),
            ),
          ),
          completer: completer,
        ),
      );
    }
  }

  _cancel() {}

  _setSubstitute(List<User> value) {
    setState(() {
      substitutes = value.map((e) => e.id).toList();
    });
  }

  setStartTime(String value) {
    setState(() {
      startTime = value;
    });
  }

  setEndTime(String value) {
    setState(() {
      endTime = value;
    });
  }

  _setDetailedReason(String value) {
    setState(() {
      detailedReason = value;
    });
  }

  _setReason(EnumTakeLeave value) {
    setState(() {
      reason = value;
    });
  }

  bool _checkValue(BuildContext context) {
    return true;
  }

  EnumTakeLeave listEnumTakeLeave() {
    switch (widget.type) {
      case RequisitionTypeEnum.yearlyAndSeniorityLeave:
        return EnumTakeLeave.yearlyLeave;
      case RequisitionTypeEnum.compensatoryLeave:
        return EnumTakeLeave.compensatoryLeave;
      case RequisitionTypeEnum.otherLeave:
        return EnumTakeLeave.weddingLeave;
      case RequisitionTypeEnum.unpaidLeave:
        return EnumTakeLeave.homeSickLeave;
      default:
        return EnumTakeLeave.yearlyLeave;
    }
  }
}
