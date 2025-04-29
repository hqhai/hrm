import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
import 'package:base_app/common/utils/error_utils.dart';
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
        date: data["date"] == null
            ? DateTime.now()
            : DateTime.parse(data['date']),
      );
    });

class CreateRequestVehicleDispatchPage extends StatefulWidget {
  const CreateRequestVehicleDispatchPage({
    super.key,
    this.flowId,
    this.requestId = '',
    this.date,
  });

  final String? flowId;
  final String requestId;
  final DateTime? date;

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
  DateTime startTime = DateTime.now(), endTime = DateTime.now();
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;
  bool checkClick = false;

  List<String> followers = [], subtitudePersons = [];

  @override
  void initState() {
    if (widget.requestId.isNotEmpty) {
      final request = dI<RequisitionBloc>().state.requisition;
      content = request.config.content;
      contentController.text = request.config.content;
      subtitudePersons = [...request.config.subtitudePersons];
      description = request.config.description;
      descriptionController.text = request.config.description;
      startTime = request.config.startDate ?? DateTime.now();
      endTime = request.config.endDate ?? DateTime.now();
      followers = [...request.followerIds];
    } else {
      final currentDate = widget.date ?? DateTime.now();
      startTime = DateTime(currentDate.year, currentDate.month, currentDate.day,
          DateTime.now().hour, DateTime.now().minute);
      endTime = DateTime(currentDate.year, currentDate.month, currentDate.day,
          DateTime.now().hour, DateTime.now().minute);
    }

    super.initState();
  }

  bool checkTime() {
    final check =
        totalMinute > 0 || endTime.difference(startTime).inSeconds > 0;
    return check;
  }

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkDescription = description != '' && description != null;
    final bool checkContent = content != '' && content != null;
    final bool check = checkDescription && checkContent;
    setState(() {
      errorSubtitude = appLocalizations.cannotBeLeftBlank;
      errorTime =
          !checkTime() ? appLocalizations.endTimeMustBeAfterStartTime : "";
      errorSchedule =
          checkDescription ? '' : appLocalizations.cannotBeLeftBlank;
      errorContent = checkContent ? '' : appLocalizations.cannotBeLeftBlank;
    });
    return check && checkTime();
  }

  double opacity() {
    bool check =
        checkLoad == false && checkSuccess == false && checkUnSuccess == false;
    return check ? 1 : 0.3;
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
                      requiredValidate: true,
                      error: errorContent,
                      textController: contentController,
                      title: appLocalizations.reasonForDriving,
                      onChange: (value) => _setContent(value),
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
                      requiredValidate: true,
                      error: subtitudePersons.isNotEmpty ? '' : errorSubtitude,
                      listFollower:
                          _setListUser(stateUserById.subtitudePersons),
                      title: appLocalizations.walker,
                      onChange: (value) => _setWalker(value),
                    ),
                    ItemCreateInputArea(
                      requiredValidate: true,
                      error: errorSchedule,
                      textController: descriptionController,
                      title: appLocalizations.schedule,
                      onChange: (value) => _setSchedule(value),
                    ),
                    // ItemCreateFollower(
                    //   listFollower: _setListUser(stateUserById.userById),
                    //   title: appLocalizations.follower,
                    //   onChange: (value) => _setFollower(value),
                    // ),
                    const ItemListStepFlow(),
                    ItemButton(
                      id: widget.requestId,
                      callbackSave: () => _save(),
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

  _setWalker(List<User> value) {
    setState(() {
      subtitudePersons = value.map((e) => e.id).toList();
    });
  }

  // _setFollower(List<User> value) {
  //   setState(() {
  //     followers = value.map((e) => e.id).toList();
  //   });
  // }

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
              subtitudePersons: subtitudePersons,
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
              subtitudePersons: subtitudePersons,
            ),
          );
  }

  _save() async {
    saveRequest(
      checkCreate:
          !checkClick && _checkValue(context) && widget.requestId.isEmpty,
      postRequestRequest: request(),
      checkEdit:
          !checkClick && _checkValue(context) && widget.requestId.isNotEmpty,
      checkLoadTrue: () => setCheckLoad(),
    );
  }

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
