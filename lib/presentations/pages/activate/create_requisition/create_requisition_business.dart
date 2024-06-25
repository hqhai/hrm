import 'dart:async';
import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_request_model.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create_interval_on_leave.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
  const CreateRequisitionBusinessPage({super.key, this.flowId = '', this.requestId});

  final String flowId;
  final String? requestId;

  @override
  State<CreateRequisitionBusinessPage> createState() => _CreateRequisitionBusinessPageState();
}

class _CreateRequisitionBusinessPageState extends State<CreateRequisitionBusinessPage> {
  final TextEditingController detailedDescriptionController = TextEditingController(),
      vehicleController = TextEditingController(),
      destinationController = TextEditingController(),
      contentController = TextEditingController();
  double total = 0;
  String errorTime = '',
      errorReason = '',
      errorContent = '',
      errorVehicle = '',
      errorDestination = '';
  String? startTime, endTime, content, reason, vehicle, destination;
  List<File> files = [];
  List<String> followers = [], substitutes = [];
  RequisitionTypeOnLeaveEnum? reasonForOnLeave = RequisitionTypeOnLeaveEnum.sickLeave;
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;

  @override
  void initState() {
    if (widget.requestId?.isNotEmpty ?? false) {
      dI<RequisitionBloc>().add(
        GetRequisitionByIdEvent(id: widget.requestId),
      );
    }
    super.initState();
  }

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkTime = total > 0;
    final DateTime now = DateTime.now();
    final bool checkStartTime =
        DateTime.parse(startTime ?? now.toString()).difference(now).inSeconds > 0;
    final bool check = reason != null && vehicle != null && destination != null && content != null;
    setState(() {
      errorTime = !checkStartTime
          ? appLocalizations.theStartTimeMustBeAfterTheCurrentTime
          : !checkTime
              ? appLocalizations.endTimeMustBeAfterStartTime
              : "";
      errorReason = reason != null ? '' : appLocalizations.cannotBeLeftBlank;
      errorContent = content != null ? '' : appLocalizations.cannotBeLeftBlank;
      errorVehicle = vehicle != null ? '' : appLocalizations.cannotBeLeftBlank;
      errorDestination = destination != null ? '' : appLocalizations.cannotBeLeftBlank;
    });
    return check && checkStartTime && checkTime;
  }

  _listener(BuildContext context, RequisitionState state) {
    if (state.statusGetById == RequisitionEnum.success) {
      setState(() {
        startTime = formatYMDHMS(state.requisition.config.startDate ?? "");
        endTime = formatYMDHMS(state.requisition.config.endDate ?? "");
        content = state.requisition.config.content ?? "";
        contentController.text = content ?? "";
        reason = state.requisition.config.description ?? "";
        detailedDescriptionController.text = reason ?? "";
        vehicle = state.requisition.config.vehicle ?? "";
        vehicleController.text = vehicle ?? "";
        destination = state.requisition.config.description ?? "";
        destinationController.text = destination ?? "";
        followers = state.requisition.followerIds;
        substitutes = state.requisition.config.subtitudePersons ?? [];
        total = state.requisition.config.total ?? 0;
        dI<UserByIdBloc>().add(
          GetUsersByIdEvent(ids: state.requisition.followerIds),
        );
        dI<UserByIdBloc>().add(
          GetSubtitudePersonsByIdEvent(
            ids: state.requisition.config.subtitudePersons ?? [],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RequisitionTypeEnum.bussiness.configTypeName,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
      body: BlocConsumer<RequisitionBloc, RequisitionState>(
        listener: (context, state) => _listener(context, state),
        listenWhen: (previous, current) => _listenWhen(previous, current),
        builder: (context, state) => BlocBuilder<UserByIdBloc, UserByIdState>(
          builder: (context, stateUserById) {
            return Stack(
              children: [
                SingleChildScrollView(
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
                        ItemCreateIntervalOnLeave(
                          endTimeOld: endTime,
                          startTimeOld: startTime,
                          error: errorTime,
                          dayOrHours: false,
                          title: appLocalizations.intervalOnLeave,
                          startTime: (value) => setStartTime(value),
                          endTime: (value) => setEndTime(value),
                          total: (value) => setTotal(value),
                        ),
                        ItemCreateInputArea(
                          error: errorDestination,
                          textController: detailedDescriptionController,
                          title: appLocalizations.detailedDescription,
                          onChange: (value) => _setReason(value),
                        ),
                        ItemCreateInputArea(
                          error: errorContent,
                          textController: contentController,
                          title: appLocalizations.content,
                          onChange: (value) => _setContent(value),
                        ),
                        ItemCreateFollower(
                            listFollower: _setListUser(stateUserById.subtitudePersons),
                            title: appLocalizations.accompanyingPerson,
                            onChange: (value) => _setSubstitute(value)),
                        ItemCreateFollower(
                            listFollower: _setListUser(stateUserById.userById),
                            title: appLocalizations.follower,
                            onChange: (value) => _setFollower(value)),
                        ItemCreateInput(
                          error: errorVehicle,
                          title: appLocalizations.vehicle,
                          inputController: vehicleController,
                          onChange: (value) => _setVehicle(value),
                        ),
                        ItemCreateInput(
                          error: errorDestination,
                          title: appLocalizations.destination,
                          inputController: destinationController,
                          onChange: (value) => _setDestination(value),
                        ),
                        ItemButton(
                          callbackSave: () => _save(context),
                          callbackCancel: () => _cancel(),
                        )
                      ],
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
            );
          },
        ),
      ),
    );
  }

  List<User> _setListUser(List<User> userById) {
    if (widget.requestId != null) {
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

  _save(BuildContext context) async {
    if (_checkValue(context) && widget.requestId == null) {
      setState(() {
        checkLoad = true;
      });
      Completer completer = Completer<RequisitionEnum>();
      dI<RequisitionBloc>().add(
        PostRequestEvent(
          completer: completer,
          postRequestRequest: PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              description: detailedDescriptionController.text,
              destination: destinationController.text,
              content: contentController.text,
              vehicle: vehicleController.text,
              endDate: formatIso8601(endTime),
              startDate: formatIso8601(startTime),
              subtitudePersons: substitutes,
              total: total,
            ),
          ),
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
          completer: completer,
          postRequestRequest: PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              description: detailedDescriptionController.text,
              destination: destinationController.text,
              content: contentController.text,
              vehicle: vehicleController.text,
              endDate: formatIso8601(endTime),
              startDate: formatIso8601(startTime),
              subtitudePersons: substitutes,
              total: total,
            ),
          ),
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

  setTotal(int value) {
    setState(() {
      total = double.parse(value.toString());
    });
  }

  bool _listenWhen(RequisitionState statusP, RequisitionState statusC) {
    return statusP != statusC;
  }
}
