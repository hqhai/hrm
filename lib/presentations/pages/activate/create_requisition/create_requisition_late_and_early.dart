import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_model_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
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
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_time_keeping_type.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/date_over_time.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/time_over_time.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_reason.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
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
  String errorTime = '', errorDestination = '', errorDialog = '', errorShift = '';
  DateTime? workDate, endDate;
  String? description;
  List<String> followers = [];
  int startTime = 0, endTime = 0;
  bool checkShirt = true, checkShirtFirst = true;
  bool checkClick = false;
  EditTimekeeping type = EditTimekeeping.late;
  List<WorkShiftRegisteredDetail> listWorkShift = [];
  List<bool> checkTypeContainer = [];
  EnumReason reason = EnumReason.individual;

  @override
  void initState() {
    if (widget.requestId.isNotEmpty) {
      final request = dI<RequisitionBloc>().state.requisition;
      workDate = request.config.startDate;
      description = request.config.description ?? "";
      detailedDescriptionController.text = description ?? "";
      followers = [...request.followerIds];
      type = request.config.explanationReason ?? EditTimekeeping.late;
      endDate = request.config.endDate;
      endDate = request.config.endDate;
      startTime = request.config.startTime;
      listWorkShift = [...?request.config.workShiftSettings];
      checkShirtFirst = false;
    }
    super.initState();
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
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<UserByIdBloc, UserByIdState>(
      builder: (context, stateUserById) {
        return BlocConsumer<RequisitionBloc, RequisitionState>(
          listener: (context, state) => _listener(state.errorCode),
          builder: (context, state) => Scaffold(
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
            body: SingleChildScrollView(
              child: ContainerScreenMain(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemCreateTimeKeepingType(
                      typeDefault: EditTimekeeping.early,
                      onChange: (value) => _setType(value),
                    ),
                    Text(
                      appLocalizations.reason,
                      style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x4,
                          fontWeight: FontWeight.w600),
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
                    Text(
                      '${appLocalizations.time} ${appLocalizations.lateOrEarly}',
                      style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x4,
                          fontWeight: FontWeight.w600),
                    ),
                    DateOverTime(
                      dateOld: workDate ?? DateTime.now(),
                      changeValue: (value) => _setWorkDate(value),
                      errorDate: errorShift,
                    ),
                    if (workDate != null && !checkShirtFirst)
                      !checkShirt
                          ? Center(
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
                            )
                          : ItemWorkShift(
                              type: widget.type,
                              workShiftSettings: (value) => setListIds(value),
                            ),
                    const SizedBox(
                      height: SpacingUnit.x4,
                    ),
                    ItemCreateInputArea(
                      error: errorDestination,
                      textController: detailedDescriptionController,
                      title: appLocalizations.detailedDescription,
                      onChange: (value) => _setDetailedDescription(value),
                    ),
                    if (type == EditTimekeeping.early)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appLocalizations.replaceDay,
                              style: TextStyle(
                                  color: colors.text,
                                  fontSize: SpacingUnit.x4,
                                  fontWeight: FontWeight.w600),
                            ),
                            DateOverTime(
                              errorDate: '',
                              dateOld: endDate,
                              changeValue: (value) => setDate(value),
                            ),
                            TimeOverTime(
                              dateOld: strSeconds(startTime) ?? "",
                              changeValue: (value) => _setStart(value),
                              title: appLocalizations.startTime,
                            ),
                            TimeOverTime(
                              dateOld: strSeconds(endTime) ?? "",
                              changeValue: (value) => _setEnd(value),
                              title: appLocalizations.endTime,
                            ),
                            if (errorTime.isNotEmpty)
                              Text(
                                errorTime,
                                style: TextStyle(
                                  color: colors.error,
                                  fontSize: SpacingUnit.x3,
                                ),
                              ),
                          ],
                        ),
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
    final bool checkDescription = description != null;
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

  _setStart(String value) {
    setState(() {
      startTime = timeToSeconds(value);
    });
  }

  _setEnd(String value) {
    setState(() {
      endTime = timeToSeconds(value);
    });
  }

  _setReasonType(EnumReason value) {
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
              explanationReason: type,
              reason: reason,
              startDate: workDate,
              endDate: endDate,
              startTime: startTime,
              endTime: endTime,
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
              endDate: endDate,
              startTime: startTime,
              endTime: endTime,
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

  _setWorkDate(DateTime value) async {
    setState(() {
      workDate = value;
    });
    if (checkShirt && workDate != null) {
      setState(() {
        checkShirt = false;
        checkShirtFirst = false;
      });
      Completer completer = Completer<bool>();
      dI<LeaveShiftBloc>()
          .add(GetWorkShiftsEvent(endDate: workDate!, startDate: workDate!, completer: completer));
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
  }
}
