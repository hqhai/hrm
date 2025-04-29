import 'dart:async';
import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
import 'package:base_app/common/utils/error_utils.dart';
import 'package:base_app/common/utils/limit_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_model_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/requisition/work_shift_registered_details.dart';
// import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_event.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/pages/activate/leave/item_work_shift.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/business/number_work.dart';
// import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_load_flie.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create.work.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create_take_leave.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_year_leave.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/custom/period_time_picker.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:themes/themes.dart';

final createRequestLeavePageRoute = GoRoute(
    path: Pages.createRequestLeavePage,
    name: Pages.createRequestLeavePage,
    builder: (context, GoRouterState state) {
      debugPrint('🔎 : ${state.extra} ❗️');
      Map data = state.extra == null ? {} : state.extra as Map;
      return CreateRequisitionLeavePage(
        flowId: data['flowId'],
        requestId: data['requestId'],
        type: data['type'],
        date: data["date"] == null
            ? DateTime.now()
            : DateTime.parse(data['date']),
      );
    });

class CreateRequisitionLeavePage extends StatefulWidget {
  const CreateRequisitionLeavePage({
    super.key,
    this.flowId = '',
    this.requestId = '',
    this.type = RequisitionTypeEnum.leaveHalfDayToOneDay,
    this.date,
  });

  final RequisitionTypeEnum type;
  final String flowId;
  final String requestId;
  final DateTime? date;

  @override
  State<CreateRequisitionLeavePage> createState() =>
      _CreateRequisitionLeavePageState();
}

class _CreateRequisitionLeavePageState
    extends State<CreateRequisitionLeavePage> {
  final TextEditingController detailedDescriptionController =
      TextEditingController();
  String description = '';
  DateTime? startTime, endTime;
  double numberValue = 0;
  List<File> files = [];
  List<String> followers = [], substitutes = [];
  List<WorkShiftRegisteredDetail> listWorkShift = [];
  bool checkShirt = true, checkShirtFirst = true;
  String errorShift = '', errorDialog = '', errorDescription = '';
  bool checkClick = false;
  final DateTime now = DateTime.now();
  EnumTakeLeaveType takeLeaveType =
      EnumTakeLeaveType.yearlyLeaveAndSeniorityLeave;
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
        detailedDescriptionController.text = description;
        reason = request.config.reasonLeave;
        followers = [...request.followerIds];
        takeLeaveType = request.config.takeLeaveType;
        socialInsuranceLeave = request.config.socialInsuranceLeave;
        files = [...setListFiles(request.config.attachments)];
        substitutes = [...request.config.subtitudePersons];
        listWorkShift = [...request.config.workShiftSettings];
        checkShirtFirst = false;
        if (listWorkShift.isNotEmpty) {
          numberValue = _getNumberValue();
        }
      });
      /* dI<LeaveShiftBloc>().add(GetWorkShiftsEvent(
        endDate: endTime ?? DateTime.now(),
        startDate: startTime ?? DateTime.now(),
      ));*/
    }
    detailedDescriptionController.addListener(_checkWords);
    super.initState();
  }

  double _getNumberValue() =>
      listWorkShift.map((e) => e.workEffort).reduce((a, b) => a + b);

  _checkWords() {
    final text = detailedDescriptionController.text;
    final words = text.trim().split(RegExp(r'\s+'));
    if (words.length > Limit.limitText) {
      setState(() {
        errorDescription = "Vượt quá giới hạn 255 từ";
      });
      final limitedText = words.sublist(0, Limit.limitText).join(' ');
      detailedDescriptionController.value = TextEditingValue(
        text: limitedText,
        selection: TextSelection.fromPosition(
          TextPosition(offset: limitedText.length),
        ),
      );
    } else {
      setState(() {
        errorDescription = '';
      });
    }
  }

  bool checkValidate(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final checkListWorkShift = listWorkShift.isNotEmpty;
    setState(() {
      errorShift =
          !checkListWorkShift ? appLocalizations.notSelectedAShift : '';
    });

    return checkListWorkShift;
  }

  List<File> setListFiles(List<String> paths) {
    return paths.map((e) => File(e)).toList();
  }

  _listener(String errorCode, BuildContext context) {
    setState(() {
      errorDialog = errorCode.isNotEmpty
          ? ErrorUtils.getErrorMessage(errorCode, context: context)
          : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(state.errorCode, context),
      builder: (context, state) {
        return BlocBuilder<UserByIdBloc, UserByIdState>(
          builder: (context, stateUserById) {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: colors.text),
                title: Text(
                  widget.type.configTypeCreateName,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x5,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: ContainerScreenMain(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ItemTakeLeave(
                        type: takeLeaveType,
                        onChangeType: (value) => _setType(value),
                      ),
                      const SizedBox(height: SpacingUnit.x4),
                      ItemYearLeave(
                        typeReason: reason,
                        typeSocialInsurance: socialInsuranceLeave,
                        onChange: (value) => _setReason(value),
                        type: takeLeaveType,
                        onChangeSocialInsurance: (value) =>
                            setSocialInsurance(value),
                      ),
                      if (takeLeaveType != EnumTakeLeaveType.unpaidLeave &&
                          checkReason())
                        ItemTakeLeaveWork(
                            reasonLeave: reason, type: takeLeaveType),
                      const SizedBox(height: SpacingUnit.x4),
                      TitleRequired(
                          title: appLocalizations.intervalOnLeave,
                          requiredValidate: true),
                      const SizedBox(height: SpacingUnit.x2),
                      PeriodTimePicker(
                        oldEndTime: endTime,
                        oldStarTime: startTime,
                        title: appLocalizations.intervalOnLeave,
                        setStarTime: (value) =>
                            setStartTime(value ?? DateTime.now()),
                        setEndTime: (value) =>
                            setEndTime(value ?? DateTime.now()),
                        fontWeightTitle: FontWeight.w600,
                      ),
                      if (!checkShirtFirst) ...[
                        const SizedBox(height: SpacingUnit.x4),
                        !checkShirt
                            ? Center(
                                child: Lottie.asset(
                                Assets.gif.loading,
                                height: 50,
                                width: 50,
                              ))
                            : ItemWorkShift(
                                workShiftSettingsOld: listWorkShift,
                                workShiftSettings: (value) => setListIds(value),
                              ),
                      ],
                      BlocBuilder<LeaveShiftBloc, LeaveShiftState>(
                        builder: (context, stateShift) {
                          return (errorShift.isNotEmpty) &&
                                      stateShift.keys.isNotEmpty ||
                                  checkShirtFirst
                              ? Text(
                                  errorShift,
                                  style: TextStyle(
                                    color: colors.error,
                                    fontSize: SpacingUnit.x3,
                                  ),
                                )
                              : const SizedBox();
                        },
                      ),
                      if (!checkShirtFirst && checkShirt)
                        NumberWorkWidget(
                          title: appLocalizations.totalLeaveWork,
                          value: numberValue.toString(),
                        ),
                      // ItemCreateFollower(
                      //   listFollower:
                      //       _setListUser(stateUserById.subtitudePersons),
                      //   title: appLocalizations.substitute,
                      //   onChange: (value) => _setSubstitute(value),
                      // ),
                      // ItemCreateFollower(
                      //   listFollower: _setListUser(stateUserById.userById),
                      //   title: appLocalizations.follower,
                      //   onChange: (value) => _setFollower(value),
                      // ),
                      ItemLoadFile(
                        files: files,
                        onChangeFiles: (value) => _setFile(value),
                      ),
                      ItemCreateInputArea(
                        textInputFormatter: [
                          LengthLimitingTextInputFormatter(500)
                        ],
                        error: errorDescription,
                        textController: detailedDescriptionController,
                        title: appLocalizations.detailedDescription,
                        onChange: (value) => _setDescription(value),
                      ),
                      const ItemListStepFlow(),
                      ItemButton(
                        id: widget.requestId,
                        callbackSave: () => _save(context),
                        callbackCancel: () => _cancel(context),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // List<User> _setListUser(List<User> userById) {
  //   if (widget.requestId.isNotEmpty) {
  //     return userById;
  //   }
  //   return [];
  // }

  // _setFollower(List<User> value) {
  //   setState(() {
  //     followers = value.map((e) => e.id).toList();
  //   });
  // }

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
            config: ConfigModelRequest(
              takeLeaveReason: reason,
              description: detailedDescriptionController.text,
              subtitudePersons: substitutes,
              endDate: endTime,
              startDate: startTime,
              workShiftSettings: listWorkShift,
              reasonLeave: reason,
              socialInsuranceLeave: socialInsuranceLeave,
              takeLeaveType: takeLeaveType,
              numberValue: numberValue,
            ),
          )
        : PostRequestRequest(
            id: widget.requestId,
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
                takeLeaveReason: reason,
                description: detailedDescriptionController.text,
                subtitudePersons: substitutes,
                endDate: endTime,
                startDate: startTime,
                workShiftSettings: listWorkShift,
                reasonLeave: reason,
                socialInsuranceLeave: socialInsuranceLeave,
                takeLeaveType: takeLeaveType,
                numberValue: numberValue),
          );
  }

  _save(BuildContext context) async {
    saveRequest(
      files: files,
      checkCreate: !checkClick &&
          widget.requestId.isEmpty &&
          checkValidate(context) &&
          checkReason(),
      postRequestRequest: request(),
      checkEdit: !checkClick &&
          widget.requestId.isNotEmpty &&
          checkValidate(context) &&
          checkReason(),
      checkLoadTrue: () => setCheckLoad(),
    );
  }

  _cancel(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  // _setSubstitute(List<User> value) {
  //   setState(() {
  //     substitutes = value.map((e) => e.id).toList();
  //   });
  // }

  setStartTime(DateTime value) {
    setState(() {
      startTime = value;
    });
  }

  setEndTime(DateTime value) async {
    setState(() {
      endTime = value;
      checkShirt = false;
    });
    if (startTime != null && endTime != null) {
      setState(() {
        checkShirtFirst = false;
        listWorkShift = [];
        numberValue = 0;
      });
      Completer completer = Completer<bool>();
      dI<LeaveShiftBloc>().add(GetWorkShiftsEvent(
          endDate: endTime!, startDate: startTime!, completer: completer));
      final check = await completer.future;
      if (check) {
        setState(() {
          checkShirt = true;
        });
      }
    }
  }

  bool checkReason() {
    switch (takeLeaveType) {
      case EnumTakeLeaveType.yearlyLeaveAndSeniorityLeave:
        return reason == EnumReasonLeave.yearlyLeave ||
            reason == EnumReasonLeave.seniorityLeave;
      case EnumTakeLeaveType.unpaidLeave:
        bool checkR = reason == EnumReasonLeave.noSalaryLeave ||
            reason == EnumReasonLeave.socialInsuranceLeave;
        bool checkS = reason != EnumReasonLeave.socialInsuranceLeave ||
            (reason == EnumReasonLeave.socialInsuranceLeave &&
                socialInsuranceLeave != null);
        return checkR && checkS;
      case EnumTakeLeaveType.compensatoryLeave:
        return true;
      case EnumTakeLeaveType.otherPaidLeave:
        return reason == EnumReasonLeave.mourningLeave ||
            reason == EnumReasonLeave.weddingLeave;
      default:
        return false;
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
      if (value == EnumTakeLeaveType.compensatoryLeave) {
        reason = null;
      }
    });
  }

  setListIds(List<WorkShiftRegisteredDetail> value) {
    setState(() {
      listWorkShift = value;
      if (value.isNotEmpty) {
        numberValue = _getNumberValue();
      } else {
        numberValue = 0;
      }
    });
  }

  setSocialInsurance(EnumSocialInsuranceLeave? value) {
    setState(() {
      socialInsuranceLeave = value;
    });
  }
}
