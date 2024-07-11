import 'dart:async';
import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_request_model.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_load_flie.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create.work.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create_interval_on_leave.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create_take_leave.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
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
  String? description, detailedReason;
  DateTime? startTime, endTime;
  EnumTakeLeave? reason;
  List<File> files = [];
  List<String> followers = [], substitutes = [];
  RequisitionTypeEnum? reasonForOnLeave = RequisitionTypeEnum.yearlyAndSeniorityLeave;
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;
  String errorTime = '';
  bool checkClick = false;
  final DateTime now = DateTime.now();

  @override
  void initState() {
    reasonForOnLeave = widget.type;
    reason = listEnumTakeLeave();
    dI<WorkAndSalaryBloc>().add(const GetTotalLeaveDayEvent());
    if (widget.requestId?.isNotEmpty ?? false) {
      dI<RequisitionBloc>().add(
        GetRequisitionByIdEvent(id: widget.requestId),
      );
    }
    super.initState();
  }

  bool _listenWhen(RequisitionState statusP, RequisitionState statusC) {
    return statusP != statusC;
  }

  List<File> setListFiles(List<String> paths) {
    return paths.map((e) => File(e)).toList();
  }

  double opacity() {
    bool check = checkLoad == false && checkSuccess == false && checkUnSuccess == false;
    return check ? 1 : 0.3;
  }

  _listener(BuildContext context, RequisitionState state) {
    if (state.statusGetById == RequisitionEnum.success && widget.requestId != null) {
      setState(() {
        startTime = state.requisition.config.startDate;
        endTime = state.requisition.config.endDate;
        description = state.requisition.config.description;
        detailedDescriptionController.text = description ?? "";
        reason = state.requisition.config.takeLeaveReason;
        followers = [...state.requisition.followerIds];
        files = [...setListFiles(state.requisition.config.attachments ?? [])];
        substitutes = [...?state.requisition.config.subtitudePersons];
      });
    }
  }

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final DateTime now = DateTime.now();
    final bool checkTime = (startTime ?? now).difference(endTime ?? now).inSeconds < 0;
    final bool checkStartTime = (startTime ?? now).difference(now).inSeconds > 0;
    setState(() {
      errorTime = !checkStartTime
          ? appLocalizations.theStartTimeMustBeAfterTheCurrentTime
          : !checkTime
              ? appLocalizations.endTimeMustBeAfterStartTime
              : "";
    });
    return checkTime && checkStartTime;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listenWhen: (previous, current) => _listenWhen(previous, current),
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return BlocBuilder<UserByIdBloc, UserByIdState>(
          builder: (context, stateUserById) {
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
              body: Stack(
                children: [
                  Opacity(
                    opacity: opacity(),
                    child: SingleChildScrollView(
                      child: ContainerScreenMain(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ItemCreateIntervalOnLeave(
                              leave: true,
                              error: errorTime,
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
                            const ItemTakeLeaveWork(),
                            if (_checkType())
                              ItemCreateInputArea(
                                textController: detailedReasonController,
                                title: appLocalizations.detailedReason,
                                onChange: (value) => _setDetailedReason(value),
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
    if (widget.requestId != null) {
      return userById;
    }
    return [];
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

  _save(BuildContext context) async {
    if (_checkValue(context) && widget.requestId == null) {
      setState(() {
        checkLoad = true;
      });
      Completer completer = Completer<RequisitionEnum>();
      dI<RequisitionBloc>().add(
        PostRequestEvent(
          files: files,
          postRequestRequest: PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              takeLeaveReason: reason,
              description: detailedDescriptionController.text,
              subtitudePersons: substitutes,
              endDate: endTime,
              startDate: startTime,
            ),
          ),
          completer: completer,
        ),
      );
      final status = await completer.future;
      if (status == RequisitionEnum.success) {
        setState(() {
          checkLoad = false;
          checkSuccess = true;
        });
      }
      if (status == RequisitionEnum.fail) {
        setState(() {
          checkLoad = false;
          checkUnSuccess = true;
        });
      }
    } else if (_checkValue(context) && widget.requestId != null) {
      setState(() {
        checkLoad = true;
      });
      Completer completer = Completer<RequisitionEnum>();
      dI<RequisitionBloc>().add(
        EditRequestEvent(
          files: files,
          postRequestRequest: PostRequestRequest(
            followerIds: followers,
            id: widget.requestId,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              takeLeaveReason: reason,
              description: detailedDescriptionController.text,
              subtitudePersons: substitutes,
              endDate: endTime,
              startDate: startTime,
            ),
          ),
          completer: completer,
        ),
      );
      final status = await completer.future;
      if (status == RequisitionEnum.success) {
        setState(() {
          checkLoad = false;
          checkSuccess = true;
        });
      }
      if (status == RequisitionEnum.fail) {
        setState(() {
          checkLoad = false;
          checkUnSuccess = true;
        });
      }
    }
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

  setEndTime(DateTime value) {
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
