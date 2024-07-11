
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
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
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create_interval_on_leave.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequestVehicleDispatchPageRoute = GoRoute(
    path: Pages.createRequestVehicleDispatchPage,
    name: Pages.createRequestVehicleDispatchPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return CreateRequestVehicleDispatchPage(
        flowId: data['flowId'],
        requestId: data['requestId'],
      );
    });

class CreateRequestVehicleDispatchPage extends StatefulWidget {
  const CreateRequestVehicleDispatchPage({super.key, this.flowId, this.requestId});

  final String? flowId;
  final String? requestId;

  @override
  State<CreateRequestVehicleDispatchPage> createState() => _CreateRequestVehicleDispatchPageState();
}

class _CreateRequestVehicleDispatchPageState extends State<CreateRequestVehicleDispatchPage> {
  final TextEditingController descriptionController = TextEditingController(),
      contentController = TextEditingController();
  int totalMinute = 0;
  String errorTime = '', errorSchedule = '', errorContent = '', errorSubtitude = '';
  String? description, content;
  DateTime? startTime, endTime;
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;
  final DateTime now = DateTime.now();
  bool checkClick = false;

  List<String> followers = [], subtitudePersons = [];

  @override
  void initState() {
    if (widget.requestId?.isNotEmpty ?? false) {
      dI<RequisitionBloc>().add(
        GetRequisitionByIdEvent(id: widget.requestId),
      );
    }
    super.initState();
  }

  _listener(BuildContext context, RequisitionState state) {
    if (state.status == RequisitionEnum.success && widget.requestId != null) {
      setState(() {
        content = state.requisition.config.content ?? "";
        contentController.text = state.requisition.config.content ?? "";
        subtitudePersons = [...?state.requisition.config.subtitudePersons];
        description = state.requisition.config.description ?? "";
        descriptionController.text = state.requisition.config.description ?? "";
        startTime = state.requisition.config.startDate;
        endTime = state.requisition.config.endDate;
        followers = [...state.requisition.followerIds];
      });
    }
  }

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkTime =
        totalMinute > 0 || (endTime ?? now).difference(startTime ?? now).inSeconds > 0;
    final bool checkStart = (endTime ?? now).difference(DateTime.now()).inSeconds > 0;
    final bool checkDescription = description != '' && description != null;
    final bool checkContent = content != '' && content != null;
    final bool check = checkDescription && checkContent && subtitudePersons.isNotEmpty;
    setState(() {
      errorSubtitude = subtitudePersons.isNotEmpty ? '' : appLocalizations.cannotBeLeftBlank;
      errorTime = !checkStart
          ? appLocalizations.theStartTimeMustBeAfterTheCurrentTime
          : !checkTime
              ? appLocalizations.endTimeMustBeAfterStartTime
              : "";
      errorSchedule = checkDescription ? '' : appLocalizations.cannotBeLeftBlank;
      errorContent = checkContent ? '' : appLocalizations.cannotBeLeftBlank;
    });

    return check && checkTime && checkStart;
  }

  double opacity() {
    bool check = checkLoad == false && checkSuccess == false && checkUnSuccess == false;
    return check ? 1 : 0.3;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(context, state),
      listenWhen: (previous, current) => previous.requisition != current.requisition,
      builder: (context, state) => BlocBuilder<UserByIdBloc, UserByIdState>(
        builder: (context, stateUserById) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                RequisitionTypeEnum.vehicleDriver.configTypeName,
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
                            endTimeOld: endTime,
                            startTimeOld: startTime,
                            error: errorTime,
                            dayOrHours: false,
                            title: appLocalizations.drivingTime,
                            startTime: (value) => setStartTime(value),
                            endTime: (value) => setEndTime(value),
                            total: (value) => setTotal(value),
                          ),
                          ItemCreateInputArea(
                            error: errorSchedule,
                            textController: descriptionController,
                            title: appLocalizations.schedule,
                            onChange: (value) => _setSchedule(value),
                          ),
                          ItemCreateInputArea(
                            error: errorContent,
                            textController: contentController,
                            title: appLocalizations.reasonForDriving,
                            onChange: (value) => _setContent(value),
                          ),
                          ItemCreateFollower(
                            error: errorSubtitude,
                            listFollower: _setListUser(stateUserById.subtitudePersons),
                            title: appLocalizations.walker,
                            onChange: (value) => _setWalker(value),
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                CheckLoadDialog(
                  fail: setErrorValue(
                    state.errorCode,
                  ),
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
      ),
    );
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

  _setWalker(List<User> value) {
    setState(() {
      subtitudePersons = value.map((e) => e.id).toList();
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

  _setSchedule(String value) {
    setState(() {
      description = value;
    });
  }

  _setContent(String value) {
    setState(() {
      content = value;
    });
  }

  PostRequestRequest request() {
    return widget.requestId == null
        ? PostRequestRequest(
      followerIds: followers,
      flowId: widget.flowId,
      config: ConfigRequestModel(
        description: descriptionController.text,
        content: contentController.text,
        endDate: endTime,
        startDate: startTime,
        subtitudePersons: subtitudePersons,
      ),
    )
        : PostRequestRequest(
      id: widget.requestId,
      followerIds: followers,
      flowId: widget.flowId,
      config: ConfigRequestModel(
        description: descriptionController.text,
        content: contentController.text,
        endDate: endTime,
        startDate: startTime,
        subtitudePersons: subtitudePersons,
      ),
    );
  }

  _save(BuildContext context) async {
    saveRequest(
      context: context,
      checkCreate: !checkClick && _checkValue(context) && widget.requestId == null,
      postRequestRequest: request(),
      checkEdit: !checkClick && _checkValue(context) && widget.requestId != null,
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

  _cancel(BuildContext context) {
    popDialog(context);
  }

  setTotal(int value) {
    setState(() {
      totalMinute = value;
    });
  }

  List<User> _setListUser(List<User> userById) {
    if (widget.requestId != null) {
      return userById;
    }
    return [];
  }
}
