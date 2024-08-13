import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_model_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/reqisition/work_shift_registered_details.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/pages/activate/leave/item_work_shift.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/custom/period_time_picker.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:themes/themes.dart';

final createRequestBusinessPageRoute = GoRoute(
    path: Pages.createRequestBusinessPage,
    name: Pages.createRequestBusinessPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return CreateRequisitionBusinessPage(
        flowId: data['flowId'],
        requestId: data['requestId'],
      );
    });

class CreateRequisitionBusinessPage extends StatefulWidget {
  const CreateRequisitionBusinessPage(
      {super.key, this.flowId = '', this.requestId = ''});

  final String flowId;
  final String requestId;

  @override
  State<CreateRequisitionBusinessPage> createState() =>
      _CreateRequisitionBusinessPageState();
}

class _CreateRequisitionBusinessPageState
    extends State<CreateRequisitionBusinessPage> {
  final TextEditingController detailedDescriptionController =
          TextEditingController(),
      vehicleController = TextEditingController(),
      destinationController = TextEditingController(),
      contentController = TextEditingController();
  double numberValue = 0;
  String errorTime = '',
      errorReason = '',
      errorContent = '',
      errorVehicle = '',
      errorDestination = '',
      errorDialog = '';
  String? content, reason, vehicle, destination;
  DateTime? startTime, endTime;
  List<String> followers = [], substitutes = [];
  List<WorkShiftRegisteredDetail> listWorkShift = [];
  RequisitionTypeOnLeaveEnum? reasonForOnLeave =
      RequisitionTypeOnLeaveEnum.sickLeave;
  bool checkLoad = false,
      checkSuccess = false,
      checkUnSuccess = false,
      checkShirt = true;
  bool checkClick = false;
  final DateTime now = DateTime.now();

  @override
  void initState() {
    if (widget.requestId.isNotEmpty) {
      final request = dI<RequisitionBloc>().state.requisition;
      startTime = request.config.startDate;
      endTime = request.config.endDate;
      content = request.config.content ?? "";
      contentController.text = content ?? "";
      reason = request.config.description ?? "";
      detailedDescriptionController.text = reason ?? "";
      vehicle = request.config.vehicle ?? "";
      vehicleController.text = vehicle ?? "";
      destination = request.config.description ?? "";
      destinationController.text = destination ?? "";
      followers = [...request.followerIds];
      substitutes = [...?request.config.subtitudePersons];
      numberValue = request.config.numberValue ?? 0;
      listWorkShift = [...?request.config.workShiftSettings];
    }
    super.initState();
  }

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkTime =
        (endTime ?? now).difference(startTime ?? now).inSeconds > 0;
    final bool check = reason != null &&
        vehicle != null &&
        destination != null &&
        content != null;
    setState(() {
      errorTime =
          !checkTime ? appLocalizations.endTimeMustBeAfterStartTime : "";
      errorReason = reason != null ? '' : appLocalizations.cannotBeLeftBlank;
      errorContent = content != null ? '' : appLocalizations.cannotBeLeftBlank;
      errorVehicle = vehicle != null ? '' : appLocalizations.cannotBeLeftBlank;
      errorDestination =
          destination != null ? '' : appLocalizations.cannotBeLeftBlank;
    });
    return check && checkTime;
  }

  double opacity() {
    bool check =
        checkLoad == false && checkSuccess == false && checkUnSuccess == false;
    return check ? 1 : 0.3;
  }

  _listener(String errorCode) {
    setState(() {
      errorDialog = errorCode.isNotEmpty ? setErrorValue(errorCode) ?? "" : "";
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
          RequisitionTypeEnum.bussiness.configTypeName,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
      body: BlocConsumer<RequisitionBloc, RequisitionState>(
        listener: (context, state) => _listener(state.errorCode),
        buildWhen: (previous, current) =>
            previous.requisition != current.requisition,
        builder: (context, state) => BlocBuilder<UserByIdBloc, UserByIdState>(
          builder: (context, stateUserById) {
            return SingleChildScrollView(
              child: ContainerScreenMain(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemCreateInputArea(
                      error: errorDestination,
                      textController: detailedDescriptionController,
                      title: appLocalizations.reasonForBusinessTrip,
                      onChange: (value) => _setReason(value),
                    ),
                    Text(
                      appLocalizations.titleBusiness,
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                    if (!checkShirt)
                      Center(
                        child: Shimmer.fromColors(
                          baseColor: colors.blue,
                          highlightColor: colors.background,
                          child: Text(
                            appLocalizations.loading,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: SpacingUnit.x7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    if (checkShirt) ...[
                      const SizedBox(height: SpacingUnit.x4),
                      ItemWorkShift(
                        type: RequisitionTypeEnum.bussiness,
                        numberValue: (value) => setNumberValue(value),
                        workShiftSettings: (value) => setListIds(value),
                      )
                    ],
                    ItemCreateInputArea(
                      error: errorContent,
                      textController: contentController,
                      title: appLocalizations.workingContent,
                      onChange: (value) => _setContent(value),
                    ),
                    ItemCreateFollower(
                      listFollower:
                          _setListUser(stateUserById.subtitudePersons),
                      title: appLocalizations.accompanyingPerson,
                      onChange: (value) => _setSubstitute(value),
                    ),
                    ItemCreateInput(
                      subTitle: appLocalizations.ifOto,
                      error: errorVehicle,
                      title: appLocalizations.vehicle,
                      inputController: vehicleController,
                      onChange: (value) => _setVehicle(value),
                    ),
                    ItemCreateInputArea(
                      error: errorDestination,
                      title: appLocalizations.destination,
                      textController: destinationController,
                      onChange: (value) => _setDestination(value),
                    ),
                    ItemCreateFollower(
                      listFollower: _setListUser(stateUserById.userById),
                      title: appLocalizations.follower,
                      onChange: (value) => _setFollower(value),
                    ),
                    const ItemListStepFlow(),
                    ItemButton(
                      callbackSave: () => _save(context),
                      callbackCancel: () => _cancel(context),
                    ),
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

  _setReason(String value) {
    setState(() {
      reason = value;
    });
  }

  PostRequestRequest request() {
    return widget.requestId.isEmpty
        ? PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
              description: detailedDescriptionController.text,
              destination: destinationController.text,
              content: contentController.text,
              vehicle: vehicleController.text,
              endDate: endTime ?? now,
              startDate: startTime ?? now,
              substitutesPersons: substitutes,
              numberValue: numberValue,
              workShiftSettings: listWorkShift,
            ),
          )
        : PostRequestRequest(
            id: widget.requestId,
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
              description: detailedDescriptionController.text,
              destination: destinationController.text,
              content: contentController.text,
              vehicle: vehicleController.text,
              endDate: endTime,
              startDate: startTime,
              substitutesPersons: substitutes,
              numberValue: numberValue,
              workShiftSettings: listWorkShift,
            ),
          );
  }

  _save(BuildContext context) async {
    saveRequest(
      context: context,
      checkCreate:
          !checkClick && _checkValue(context) && widget.requestId.isEmpty,
      postRequestRequest: request(),
      checkEdit:
          !checkClick && _checkValue(context) && widget.requestId.isNotEmpty,
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
    if (startTime != null && endTime != null) {
      setState(() {
        checkShirt = false;
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

  _setVehicle(String value) {
    setState(() {
      vehicle = value;
    });
  }

  _setDestination(String value) {
    setState(() {
      destination = value;
    });
  }

  _setContent(String value) {
    setState(() {
      content = value;
    });
  }

  setNumberValue(double value) {
    setState(() {
      numberValue = value;
    });
  }

  setListIds(List<WorkShiftRegisteredDetail> value) {
    setState(() {
      listWorkShift = value;
    });
  }
}
