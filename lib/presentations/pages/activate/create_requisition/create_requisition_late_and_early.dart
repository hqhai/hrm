import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_model_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/requisition/requisition_over_time.dart';
import 'package:base_app/domain/entities/requisition/work_shift_registered_details.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_event.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_time_keeping_type.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/late_early/work_shift_late_early.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/date_over_time.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/custom/app_start_end_time.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_reason.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:themes/themes.dart';

final createRequestLateAndEarlyPageRoute = GoRoute(
  path: Pages.createRequestLateAndEarlyPage,
  name: Pages.createRequestLateAndEarlyPage,
  builder: (context, GoRouterState state) {
    Map data = state.extra as Map;
    return CreateRequisitionLateAndEarlyPage(
      flowId: data['flowId'],
      requestId: data['requestId'],
      type: data['type'],
    );
  },
);

class CreateRequisitionLateAndEarlyPage extends StatefulWidget {
  const CreateRequisitionLateAndEarlyPage({
    super.key,
    this.flowId = '',
    this.requestId = '',
    this.type = RequisitionTypeEnum.lateOrEarly,
  });

  final RequisitionTypeEnum type;
  final String flowId;
  final String requestId;

  @override
  State<CreateRequisitionLateAndEarlyPage> createState() =>
      _CreateRequisitionLateAndEarlyPageState();
}

class _CreateRequisitionLateAndEarlyPageState extends State<CreateRequisitionLateAndEarlyPage> {
  final TextEditingController detailedDescriptionController = TextEditingController();
  String errorTime = '',
      errorDestination = '',
      errorDialog = '',
      errorShift = '',
      errorListener = '', description = '';
  DateTime workDate = DateTime.now(), endDate = DateTime.now();
  List<String> followers = [];
  int startTime = 0, endTime = 0;
  bool checkShirt = true;
  bool checkClick = false;
  EditTimekeeping type = EditTimekeeping.late;
  List<WorkShiftRegisteredDetail> listWorkShift = [];
  List<bool> checkTypeContainer = [];
  EnumReason reason = EnumReason.individual;
  double numberValue = 0;
  bool checkRequiredMakeUp = false;

  @override
  void initState() {
    if (widget.requestId.isNotEmpty) {
      final request = dI<RequisitionBloc>().state.requisition;
      workDate = request.config.startDate ?? DateTime.now();
      description = request.config.description;
      detailedDescriptionController.text = description;
      followers = [...request.followerIds];
      type = request.config.explanationReason ?? EditTimekeeping.late;
      endDate = request.config.endDate ?? DateTime.now();
      startTime = request.config.startTime;
      listWorkShift = [...request.config.workShiftSettings];
    }
    super.initState();
  }

  _listener(String errorCode, BuildContext context) {
    setState(() {
      errorDialog = errorCode.isNotEmpty ? setErrorValue(errorCode, context) ?? errorCode : "";
      if (errorCode == 'MakeupDayCanNotRecedeRequestDate') {
        errorListener = errorDialog;
      } else {
        errorListener = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<UserByIdBloc, UserByIdState>(
      builder: (context, stateUserById) {
        return BlocConsumer<RequisitionBloc, RequisitionState>(
          listener: (context, state) => _listener(state.errorCode, context),
          builder: (context, state) => Scaffold(
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
                    ItemCreateTimeKeepingType(
                      typeDefault: EditTimekeeping.early,
                      onChange: (value) => _setType(value),
                    ),
                    TitleRequired(
                      title: appLocalizations.reason,
                      requiredValidate: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                      child: GestureDetector(
                        onTap: () => _showBottomSheet(context),
                        child: ContainerBorder(
                          marginTop: 0,
                          paddingVertical: SpacingUnit.x4,
                          borderColors: colors.outline.withOpacity(0.3),
                          width: width,
                          child: Text(
                            reason.configEnumReasonName,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x4,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4,
                    ),
                    TitleRequired(
                      title: '${appLocalizations.time} ${appLocalizations.lateOrEarly}',
                      requiredValidate: true,
                    ),
                    DateOverTime(
                      dateOld: workDate,
                      changeValue: (value) => _setWorkDate(value),
                    ),
                    !checkShirt
                        ? Center(
                            child: Lottie.asset(
                              Assets.gif.loading,
                              height: 50,
                              width: 50,
                            ),
                          )
                        : WorkShiftLateEarly(
                            typeLE: type,
                            type: widget.type,
                            workShiftSettings: (value) => setListIds(value),
                          ),
                    BlocBuilder<LeaveShiftBloc, LeaveShiftState>(
                      builder: (context, stateShift) {
                        return errorShift.isNotEmpty && stateShift.keys.isNotEmpty
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
                    if (checkMakeUp())
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleRequired(
                              title: appLocalizations.replaceDay,
                              requiredValidate: checkRequiredMakeUp,
                            ),
                            DateOverTime(
                              errorDate: '',
                              dateOld: endDate,
                              changeValue: (value) => setDate(value),
                            ),
                            AppStartEndTime(
                              checkRequired: checkRequiredMakeUp,
                              checkNumberValue: false,
                              endTime: endTime,
                              startTime: startTime,
                              numberValue: 0,
                              title1: appLocalizations.startTime,
                              title2: appLocalizations.endTime,
                              title3: appLocalizations.totalMakeUpWorkTime,
                              setEndTime: (value) => _setEndTime(
                                value: value,
                                title: appLocalizations.endTimeMustBeAfterStartTime,
                              ),
                              setStartTime: (value) => _setStartTime(
                                value: value,
                                title: appLocalizations.endTimeMustBeAfterStartTime,
                              ),
                              errorTime: errorListener != '' ? errorListener : errorTime,
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: SpacingUnit.x4,
                    ),
                    ItemCreateInputArea(
                      requiredValidate: true,
                      error: errorDestination,
                      textController: detailedDescriptionController,
                      title: appLocalizations.detailedDescription,
                      onChange: (value) => _setDetailedDescription(value),
                    ),
                    ItemCreateFollower(
                        listFollower: _setListUser(stateUserById.userById),
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
            ),
          ),
        );
      },
    );
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetReasonTypeWidget(
          onChange: (value) => _setReasonType(value),
        );
      },
    );
  }

  setEdit({required RequisitionOverTime value}) {}

  List<User> _setListUser(List<User> userById) {
    if (widget.requestId.isNotEmpty) {
      return userById;
    }
    return [];
  }

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkDescription = description.isNotEmpty;
    final checkShiftEmpty = listWorkShift.isNotEmpty;
    setState(() {
      errorDestination = checkDescription ? '' : appLocalizations.cannotBeLeftBlank;
      errorShift = !checkShiftEmpty ? appLocalizations.notSelectedAShift : '';
    });
    return checkDescription && checkShiftEmpty;
  }

  _setFollower(List<User> value) {
    setState(() {
      followers = value.map((e) => e.id).toList();
    });
  }

  setDate(DateTime value) {
    setState(() {
      endDate = value;
    });
  }

  _setStartTime({required int value, required String title}) {
    setState(() {
      startTime = value;
      numberValue = double.parse((endTime - startTime).toString());
      errorTime = numberValue > 0 ? '' : title;
    });
  }

  _setEndTime({required int value, required String title}) {
    setState(() {
      endTime = value;
      numberValue = double.parse((endTime - startTime).toString());
      errorTime = numberValue > 0 ? '' : title;
    });
  }

  _setReasonType(EnumReason value) {
    setState(() {
      reason = value;
    });
  }

  bool checkMakeUp() {
    return type == EditTimekeeping.early && checkRequiredMakeUp;
  }

  PostRequestRequest request() {
    return widget.requestId.isEmpty
        ? PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
              explanationReason: type,
              reason: reason,
              startDate: workDate,
              endDate: checkMakeUp() ? endDate : null,
              startTime: checkMakeUp() ? startTime : null,
              endTime: checkMakeUp() ? endTime : null,
              workShiftSettings: listWorkShift,
              description: description,
            ),
          )
        : PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
              explanationReason: type,
              reason: reason,
              startDate: workDate,
              endDate: checkMakeUp() ? endDate : null,
              startTime: checkMakeUp() ? startTime : null,
              endTime: checkMakeUp() ? endTime : null,
              workShiftSettings: listWorkShift,
              description: description,
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

  _cancel(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  _setWorkDate(DateTime value) async {
    setState(() {
      workDate = value;
    });
    if (checkShirt) {
      setState(() {
        checkShirt = false;
      });
      Completer completer = Completer<bool>();
      dI<LeaveShiftBloc>()
          .add(GetWorkShiftsEvent(endDate: workDate, startDate: workDate, completer: completer));
      final check = await completer.future;
      if (check) {
        setState(() {
          checkShirt = true;
        });
      }
    }
  }

  _setDetailedDescription(String value) {
    setState(() {
      description = value;
    });
  }

  _setType(EditTimekeeping value) {
    setState(() {
      type = value;
    });
  }

  setListIds(List<WorkShiftRegisteredDetail> value) {
    setState(() {
      listWorkShift = value;
    });
    final index = listWorkShift.indexWhere((element) => element.numberTime > 60).toInt();
    if (index != -1) {
      setState(() {
        checkRequiredMakeUp = true;
      });
    } else {
      setState(() {
        checkRequiredMakeUp = false;
      });
    }
  }
}
