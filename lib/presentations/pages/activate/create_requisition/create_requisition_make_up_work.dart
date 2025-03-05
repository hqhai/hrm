import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
import 'package:base_app/common/utils/error_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_model_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
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
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/make_up_work/item_work_shift_a_date.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/date_over_time.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/custom/app_start_end_time.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:themes/themes.dart';

final createRequestMakeUpWorkPageRoute = GoRoute(
  path: Pages.createRequestMakeUpWorkPage,
  name: Pages.createRequestMakeUpWorkPage,
  builder: (context, GoRouterState state) {
    Map data = state.extra as Map;
    return CreateRequisitionMakeUpWorkPage(
      flowId: data['flowId'],
      requestId: data['requestId'],
      type: data['type'],
    );
  },
);

class CreateRequisitionMakeUpWorkPage extends StatefulWidget {
  const CreateRequisitionMakeUpWorkPage({
    super.key,
    this.flowId = '',
    this.requestId = '',
    this.type = RequisitionTypeEnum.makeUpWork,
  });

  final RequisitionTypeEnum type;
  final String flowId;
  final String requestId;

  @override
  State<CreateRequisitionMakeUpWorkPage> createState() =>
      _CreateRequisitionMakeUpWorkPageState();
}

class _CreateRequisitionMakeUpWorkPageState
    extends State<CreateRequisitionMakeUpWorkPage> {
  final TextEditingController descriptionController = TextEditingController();
  String errorDescription = '',
      errorDialog = '',
      errorWorkShiftSettings = '',
      errorTime = '',
      description = '';
  List<String> followers = [];
  DateTime startDate = DateTime.now();
  int startTime = 0, endTime = 0;
  double numberValue = 0;
  List<WorkShiftRegisteredDetail> workShiftSettings = [];
  bool checkClick = false, checkShirt = true;

  @override
  void initState() {
    if (widget.requestId.isNotEmpty) {
      final request = dI<RequisitionBloc>().state.requisition;
      description = request.config.description;
      workShiftSettings = [...request.config.workShiftSettings];
      startDate = request.config.startDate ?? DateTime.now();
      startTime = request.config.startTime;
      endTime = request.config.endTime;
      numberValue = (request.config.numberValue);
      followers = [...request.followerIds];

      descriptionController.text = description;
    }
    super.initState();
  }

  _listener(String errorCode, BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    setState(() {
      errorDialog = errorCode.isNotEmpty
          ? ErrorUtils.getErrorMessage(errorCode, context: context)
          : "";
      if (errorCode == "TimeSlotAlreadyPleaseChooseAnother") {
        errorTime = appLocalizations.errorTimeMakeUp2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(state.errorCode, context),
      builder: (context, state) => BlocBuilder<UserByIdBloc, UserByIdState>(
        builder: (context, stateUserById) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: colors.text),
              centerTitle: true,
              title: Text(
                widget.type.configTypeCreateName,
                style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4_5,
                    fontWeight: FontWeight.w600),
              ),
            ),
            body: SingleChildScrollView(
              child: ContainerScreenMain(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemCreateInputArea(
                      requiredValidate: true,
                      error: errorDescription,
                      textController: descriptionController,
                      title: appLocalizations.reasonMakeUpWork,
                      onChange: (value) => _setDetailedDescription(value),
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4,
                    ),
                    TitleRequired(
                      title: appLocalizations.leaveDate,
                      requiredValidate: true,
                    ),
                    DateOverTime(
                      dateOld: startDate,
                      changeValue: (value) => _setStartDate(value),
                    ),
                    !checkShirt
                        ? Center(
                            child: Lottie.asset(
                            Assets.gif.loading,
                            height: 50,
                            width: 50,
                          ))
                        : ItemWorkShiftADate(
                            workShiftSettingsOld: workShiftSettings,
                            type: widget.type,
                            workShiftSettings: (value) =>
                                _setWorkShiftSettings(value),
                          ),
                    BlocBuilder<LeaveShiftBloc, LeaveShiftState>(
                      builder: (context, stateShift) {
                        return errorWorkShiftSettings.isNotEmpty ||
                                stateShift.keys.isNotEmpty
                            ? Text(
                                errorWorkShiftSettings,
                                style: TextStyle(
                                  color: colors.error,
                                  fontSize: SpacingUnit.x3,
                                ),
                              )
                            : const SizedBox();
                      },
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4,
                    ),
                    TitleRequired(
                      title: appLocalizations.makeUpWorkDate,
                      requiredValidate: true,
                    ),
                    DateOverTime(
                      dateOld: startDate,
                      changeValue: (value) => setDate(value),
                    ),
                    AppStartEndTime(
                      endTime: endTime,
                      startTime: startTime,
                      numberValue: numberValue,
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
                      errorTime: errorTime,
                      checkNumberValue: false,
                    ),
                    // ItemCreateFollower(
                    //     listFollower: _setListUser(
                    //       stateUserById.userById,
                    //     ),
                    //     title: appLocalizations.follower,
                    //     onChange: (value) => _setFollower(value)),
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
      ),
    );
  }

  List<User> _setListUser(List<User> userById) {
    if (widget.requestId.isNotEmpty) {
      return userById;
    }
    return [];
  }

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkDescription = description.isNotEmpty;
    final bool checkList = workShiftSettings.isNotEmpty;
    setState(() {
      errorDescription =
          checkDescription ? '' : appLocalizations.cannotBeLeftBlank;
      errorWorkShiftSettings =
          checkList ? '' : appLocalizations.notSelectedAShift;
    });
    return checkList && checkDescription;
  }

  _setFollower(List<User> value) {
    setState(() {
      followers = value.map((e) => e.id).toList();
    });
  }

  _setDetailedDescription(String value) {
    setState(() {
      description = value;
      /* if(value.isNotEmpty){
        errorDescription = '';
      }*/
    });
  }

  PostRequestRequest request() {
    return widget.requestId.isEmpty
        ? PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
                startDate: startDate,
                numberValue: numberValue,
                startTime: startTime,
                endTime: endTime,
                description: description,
                workShiftSettings: workShiftSettings),
          )
        : PostRequestRequest(
            id: widget.requestId,
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
                startDate: startDate,
                numberValue: numberValue,
                startTime: startTime,
                endTime: endTime,
                description: description,
                workShiftSettings: workShiftSettings),
          );
  }

  _save(BuildContext context) async {
    saveRequest(
      context: context,
      checkCreate: !checkClick &&
          _checkValue(context) &&
          widget.requestId.isEmpty &&
          checkTotalWorkLeave(context),
      postRequestRequest: request(),
      checkEdit: !checkClick &&
          _checkValue(context) &&
          widget.requestId.isNotEmpty &&
          checkTotalWorkLeave(context),
      checkLoadTrue: () => setCheckLoad(),
    );
  }

  _cancel(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  setDate(DateTime value) {
    setState(() {
      startDate = value;
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

  _setStartDate(DateTime value) async {
    setState(() {
      startDate = value;
    });
    if (checkShirt) {
      setState(() {
        checkShirt = false;
      });
      Completer completer = Completer<bool>();
      dI<LeaveShiftBloc>().add(GetWorkShiftsEvent(
          endDate: startDate, startDate: startDate, completer: completer));
      final check = await completer.future;
      if (check) {
        setState(() {
          checkShirt = true;
          errorWorkShiftSettings = '';
        });
      }
    }
  }

  bool checkTotalWorkLeave(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    double totalWorkLeave = 0;
    for (var item in workShiftSettings) {
      totalWorkLeave = totalWorkLeave + item.endTime - item.startTime;
    }
    if (totalWorkLeave > numberValue) {
      setState(() {
        errorTime = appLocalizations.errorTimeMakeUp1;
      });
      return false;
    }
    return true;
  }

  _setWorkShiftSettings(List<WorkShiftRegisteredDetail> value) {
    setState(() {
      workShiftSettings = value;
      if (workShiftSettings.isNotEmpty) {
        errorWorkShiftSettings = '';
      }
    });
  }
}
