import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_model_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_common/item_create_time_start_and_end.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
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
  const CreateRequestVehicleDispatchPage(
      {super.key, this.flowId, this.requestId = ''});

  final String? flowId;
  final String requestId;

  @override
  State<CreateRequestVehicleDispatchPage> createState() =>
      _CreateRequestVehicleDispatchPageState();
}

class _CreateRequestVehicleDispatchPageState
    extends State<CreateRequestVehicleDispatchPage> {
  final TextEditingController descriptionController = TextEditingController(),
      contentController = TextEditingController();
  double totalMinute = 0;
  String errorTime = '',
      errorSchedule = '',
      errorContent = '',
      errorSubtitude = '',
      errorDialog = '';
  String? description, content;
  DateTime? startTime, endTime;
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;
  final DateTime now = DateTime.now();
  bool checkClick = false;

  List<String> followers = [], subtitudePersons = [];

  @override
  void initState() {
    if (widget.requestId.isNotEmpty) {
      final request = dI<RequisitionBloc>().state.requisition;
      content = request.config.content ?? "";
      contentController.text = request.config.content ?? "";
      subtitudePersons = [...?request.config.subtitudePersons];
      description = request.config.description ?? "";
      descriptionController.text = request.config.description ?? "";
      startTime = request.config.startDate;
      endTime = request.config.endDate;
      followers = [...request.followerIds];
    }
    super.initState();
  }

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkTime = totalMinute > 0 ||
        (endTime ?? now).difference(startTime ?? now).inSeconds > 0;
    final bool checkDescription = description != '' && description != null;
    final bool checkContent = content != '' && content != null;
    final bool check =
        checkDescription && checkContent && subtitudePersons.isNotEmpty;
    setState(() {
      errorSubtitude =
          subtitudePersons.isNotEmpty ? '' : appLocalizations.cannotBeLeftBlank;
      errorTime =
          !checkTime ? appLocalizations.endTimeMustBeAfterStartTime : "";
      errorSchedule =
          checkDescription ? '' : appLocalizations.cannotBeLeftBlank;
      errorContent = checkContent ? '' : appLocalizations.cannotBeLeftBlank;
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
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(state.errorCode),
      builder: (context, state) => BlocBuilder<UserByIdBloc, UserByIdState>(
        builder: (context, stateUserById) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: colors.text),
              title: Text(
                RequisitionTypeEnum.vehicleDriver.configTypeName,
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
                    ItemCreateInputArea(
                      error: errorContent,
                      textController: contentController,
                      title: appLocalizations.reasonForDriving,
                      onChange: (value) => _setContent(value),
                    ),
                    ItemCreateFollower(
                      error: errorSubtitude,
                      listFollower:
                          _setListUser(stateUserById.subtitudePersons),
                      title: appLocalizations.walker,
                      onChange: (value) => _setWalker(value),
                    ),
                    ItemCreateInputArea(
                      error: errorSchedule,
                      textController: descriptionController,
                      title: appLocalizations.schedule,
                      onChange: (value) => _setSchedule(value),
                    ),
                    const SizedBox(height: SpacingUnit.x4),
                    ItemCreateTimeStartAndEnd(
                      title1: appLocalizations.timeStart,
                      title2: appLocalizations.timeEnd,
                      title3: appLocalizations.totalTime,
                      endTimeOld: endTime,
                      startTimeOld: startTime,
                      error: errorTime,
                      dayOrHours: false,
                      leave: true,
                      title: appLocalizations.drivingTime,
                      startTime: (value) => setStartTime(value),
                      endTime: (value) => setEndTime(value),
                      total: (value) => setTotal(value),
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
    return widget.requestId.isEmpty
        ? PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
              description: descriptionController.text,
              content: contentController.text,
              endDate: endTime,
              startDate: startTime,
              substitutesPersons: subtitudePersons,
            ),
          )
        : PostRequestRequest(
            id: widget.requestId,
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
              description: descriptionController.text,
              content: contentController.text,
              endDate: endTime,
              startDate: startTime,
              substitutesPersons: subtitudePersons,
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

  /*setCheckLoad() {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    dialogIndicator(context: currentContext);
  }

  completerFail() {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    dI<AppNavigation>().pop(currentContext);
    dialogUnsuccessful(
      context: currentContext,
      title: errorDialog.isNotEmpty
          ? errorDialog
          : widget.requestId.isNotEmpty
              ? appLocalizations.editRequestUnsuccessful
              : appLocalizations.createRequestFailed,
    );
  }

  completerSuccess() {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    dI<AppNavigation>().pop(currentContext);
    dialogSuccess(
      context: currentContext,
      title: widget.requestId.isNotEmpty
          ? appLocalizations.editRequestSuccess
          : appLocalizations.createSuccess,
    );
  }*/

  _cancel(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  setTotal(double value) {
    setState(() {
      totalMinute = value;
    });
  }

  List<User> _setListUser(List<User> userById) {
    if (widget.requestId.isNotEmpty) {
      return userById;
    }
    return [];
  }
}
