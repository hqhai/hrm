import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_request_model.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/pages/activate/leave/item_work_shift.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_load_flie.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create.work.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create_take_leave.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_year_leave.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/custom/period_time_picker.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    this.requestId = '',
    this.type = RequisitionTypeEnum.leaveHalfDayToOneDay,
  });

  final RequisitionTypeEnum type;
  final String flowId;
  final String requestId;

  @override
  State<CreateRequisitionLeavePage> createState() => _CreateRequisitionLeavePageState();
}

class _CreateRequisitionLeavePageState extends State<CreateRequisitionLeavePage> {
  final TextEditingController detailedDescriptionController = TextEditingController();
  String? description;
  DateTime? startTime, endTime;
  double numberValue = 0;
  List<File> files = [];
  List<String> followers = [], substitutes = [], listIdShift = [];
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;
  String errorTime = '';
  bool checkClick = false;
  final DateTime now = DateTime.now();
  EnumTakeLeaveType takeLeaveType = EnumTakeLeaveType.yearlyLeaveAndSeniorityLeave;
  EnumSocialInsuranceLeave? socialInsuranceLeave;
  EnumReasonLeave? reason;

  @override
  void initState() {
    final request = dI<RequisitionBloc>().state.requisition;
    if (widget.requestId.isNotEmpty) {
      setState(() {
        startTime = request.config.startDate;
        endTime = request.config.endDate;
        description = request.config.description;
        detailedDescriptionController.text = description ?? "";
        reason = request.config.reasonLeave;
        followers = [...request.followerIds];
        files = [...setListFiles(request.config.attachments ?? [])];
        substitutes = [...?request.config.subtitudePersons];
      });
    }
    super.initState();
  }

  List<File> setListFiles(List<String> paths) {
    return paths.map((e) => File(e)).toList();
  }

  double opacity() {
    bool check = checkLoad == false && checkSuccess == false && checkUnSuccess == false;
    return check ? 1 : 0.3;
  }

  bool checkShift() {
    if (startTime == null || endTime == null) {
      return false;
    }
    final number = (endTime!).difference(startTime!).inHours;
    if (widget.type == RequisitionTypeEnum.leaveHalfDayToOneDay && number > 24) {
      return false;
    }
    if (widget.type == RequisitionTypeEnum.leaveTwoDayToFourDay && number > 96 && number < 24) {
      return false;
    }
    if (widget.type == RequisitionTypeEnum.leaveFiveDaysOrMore && number < 96) {
      return false;
    }
    return true;
  }

  String errorDate() {
    if (startTime == null || endTime == null) {
      return '';
    }
    final number = (endTime!).difference(startTime!).inHours;
    if (widget.type == RequisitionTypeEnum.leaveHalfDayToOneDay && number > 24) {
      return RequisitionTypeEnum.leaveHalfDayToOneDay.configTypeName;
    }
    if (widget.type == RequisitionTypeEnum.leaveTwoDayToFourDay && number > 96 && number < 24) {
      return RequisitionTypeEnum.leaveTwoDayToFourDay.configTypeName;
    }
    if (widget.type == RequisitionTypeEnum.leaveFiveDaysOrMore && number < 96) {
      return RequisitionTypeEnum.leaveFiveDaysOrMore.configTypeName;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return BlocBuilder<UserByIdBloc, UserByIdState>(
          builder: (context, stateUserById) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: colors.text),
                title: Text(
                  widget.type.configTypeName,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x5,
                  ),
                ),
              ),
              body: Stack(
                children: [
                  Opacity(
                    opacity: opacity(),
                    child: SingleChildScrollView(
                      child: ContainerScreenMain(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ItemTakeLeave(
                              type: takeLeaveType,
                              onChangeType: (value) => _setType(value),
                            ),
                            ItemYearLeave(
                              typeReason: reason,
                              typeSocialInsurance: socialInsuranceLeave,
                              onChange: (value) => _setReason(value),
                              type: takeLeaveType,
                              onChangeSocialInsurance: (value) => setSocialInsurance(value),
                            ),
                            if (takeLeaveType == EnumTakeLeaveType.yearlyLeaveAndSeniorityLeave)
                              const ItemTakeLeaveWork(),
                            PeriodTimePicker(
                              oldEndTime: endTime,
                              oldStarTime: startTime,
                              fontSizeTitle: SpacingUnit.x4,
                              title: appLocalizations.intervalOnLeave,
                              setStarTime: (value) => setStartTime(value ?? DateTime.now()),
                              setEndTime: (value) => setEndTime(value ?? DateTime.now()),
                              fontWeightTitle: FontWeight.w600,
                            ),
                            if (errorDate().isNotEmpty)
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  errorDate(),
                                  style: TextStyle(
                                    color: colors.error,
                                    fontSize: SpacingUnit.x3,
                                  ),
                                ),
                              ),
                            ItemWorkShift(
                              numberValue: (value) => setNumberValue(value),
                              ids: (value) => setListIds(value),
                            ),
                            ItemCreateFollower(
                              listFollower: _setListUser(stateUserById.subtitudePersons),
                              title: appLocalizations.substitute,
                              onChange: (value) => _setSubstitute(value),
                            ),
                            ItemCreateFollower(
                              listFollower: _setListUser(stateUserById.userById),
                              title: appLocalizations.follower,
                              onChange: (value) => _setFollower(value),
                            ),
                            ItemCreateInputArea(
                              textController: detailedDescriptionController,
                              title: appLocalizations.detailedDescription,
                              onChange: (value) => _setDescription(value),
                            ),
                            ItemLoadFile(
                              files: files,
                              onChangeFiles: (value) => _setFile(value),
                            ),
                            const ItemListStepFlow(),
                            ItemButton(
                              callbackSave: () => _save(context),
                              callbackCancel: () => _cancel(),
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
        );
      },
    );
  }

  List<User> _setListUser(List<User> userById) {
    if (widget.requestId.isNotEmpty) {
      return userById;
    }
    return [];
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

  PostRequestRequest request() {
    return widget.requestId.isEmpty
        ? PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
                takeLeaveReason: reason,
                description: detailedDescriptionController.text,
                subtitudePersons: substitutes,
                endDate: endTime,
                startDate: startTime,
                workShiftSettingDetailIds: listIdShift,
                reasonLeave: reason,
                socialInsuranceLeave: socialInsuranceLeave,
                takeLeaveType: takeLeaveType,
                numberValue: numberValue,),
          )
        : PostRequestRequest(
            id: widget.requestId,
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
                takeLeaveReason: reason,
                description: detailedDescriptionController.text,
                subtitudePersons: substitutes,
                endDate: endTime,
                startDate: startTime,
                workShiftSettingDetailIds: listIdShift,
                reasonLeave: reason,
                socialInsuranceLeave: socialInsuranceLeave,
                takeLeaveType: takeLeaveType,
                numberValue: numberValue),
          );
  }

  _save(BuildContext context) async {
    saveRequest(
      files: files,
      context: context,
      checkCreate: !checkClick && widget.requestId.isEmpty,
      postRequestRequest: request(),
      checkEdit: !checkClick && widget.requestId.isNotEmpty,
      checkLoadTrue: () => setCheckLoad(),
      completerFail: () => completerFail(),
      completerSuccess: () => completerSuccess(),
    );
  }

  setCheckLoad() {
    setState(() {
      checkClick = true;
      checkLoad = true;
    });
  }

  completerFail() {
    setState(() {
      checkLoad = false;
      checkUnSuccess = true;
      checkClick = false;
    });
  }

  completerSuccess() {
    setState(() {
      checkLoad = false;
      checkSuccess = true;
      checkClick = false;
    });
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

  _cancel() {}

  _setSubstitute(List<User> value) {
    setState(() {
      substitutes = value.map((e) => e.id).toList();
    });
  }

  setStartTime(DateTime value) {
    setState(() {
      startTime = value;
    });
  }

  setEndTime(DateTime value) async {
    setState(() {
      endTime = value;
    });
    if (startTime != null && endTime != null && checkShift()) {
      dI<LeaveShiftBloc>().add(GetWorkShiftsEvent(
        endDate: endTime!,
        startDate: startTime!,
      ));
    }
  }

  _setReason(EnumReasonLeave? value) {
    setState(() {
      reason = value;
    });
  }

  _setType(EnumTakeLeaveType value) {
    setState(() {
      takeLeaveType = value;
    });
  }

  setListIds(List<String> value) {
    setState(() {
      listIdShift = value;
    });
  }

  setSocialInsurance(EnumSocialInsuranceLeave? value) {
    setState(() {
      socialInsuranceLeave = value;
    });
  }

  setNumberValue(double value) {
    setState(() {
      numberValue = value;
    });
  }
}
