import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_model_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/list_overtime.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequestOverTimePageRoute = GoRoute(
    path: Pages.createRequestOverTimePage,
    name: Pages.createRequestOverTimePage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return CreateRequisitionOverTimePage(
        flowId: data['flowId'],
        requestId: data['requestId'],
      );
    });

class CreateRequisitionOverTimePage extends StatefulWidget {
  const CreateRequisitionOverTimePage({
    super.key,
    this.flowId = '',
    this.requestId = '',
  });

  final String flowId;
  final String requestId;

  @override
  State<CreateRequisitionOverTimePage> createState() => _CreateRequisitionOverTimePageState();
}

class _CreateRequisitionOverTimePageState extends State<CreateRequisitionOverTimePage> {
  List<RequisitionOverTime> requisitionOverTimes = [];
  List<String> followers = [];
  String description = "", error = '', errorDescription = '', errorDialog = '';
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;
  bool checkClick = false;
  List<bool> checkTypeContainer = [];
  final TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    if (widget.requestId.isNotEmpty) {
      final request = dI<RequisitionBloc>().state.requisition;
      followers = request.followerIds;
      requisitionOverTimes = [...?request.config.overTimes];
      checkTypeContainer = List.filled(requisitionOverTimes.length, true);
      description = request.config.description ?? "";
      inputController.text = description;
    }
    super.initState();
  }

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool check = requisitionOverTimes.isNotEmpty;
    final bool checkDescription = description.isNotEmpty;
    setState(() {
      error = check ? '' : appLocalizations.notSelectedAOverTime;
      errorDescription = checkDescription ? '' : appLocalizations.cannotBeLeftBlank;
    });
    return check && checkDescription;
  }

  double opacity() {
    bool check = checkLoad == false && checkSuccess == false && checkUnSuccess == false;
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
                RequisitionTypeEnum.overTime.configTypeName,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x5,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: ContainerScreenMain(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListOverTime(
                        requiredValidate: true,
                        checkExplanation: true,
                        callback: () => addOverTime(),
                        checkTypeContainer: checkTypeContainer,
                        changeTypeContainer: (value) => _changeTypeContainer(value),
                        title: appLocalizations.listOvertime,
                        error: error,
                        requisitionOverTimes: requisitionOverTimes,
                        onChangeList: (value) => _setChangeRequisitionOverTimes(value),
                      ),
                      ItemCreateInputArea(
                        requiredValidate: true,
                        title: appLocalizations.reason,
                        error: errorDescription,
                        textController: inputController,
                        onChange: (value) => setDescription(value),
                      ),
                      ItemCreateFollower(
                          listFollower: _setListUser(
                            stateUserById.userById,
                          ),
                          title: appLocalizations.follower,
                          onChange: (value) => _setFollower(value)),
                      const ItemListStepFlow(),
                      Padding(
                        padding: const EdgeInsets.only(top: SpacingUnit.x3_5),
                        child: ItemButton(
                          callbackSave: () => _save(context),
                          callbackCancel: () => _cancel(context),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String timeDHM(int time) {
    final DateTime date = strSeconds(time);
    if (date.day > 1) {
      return '${date.day - 1}d${date.hour}h${date.minute}m';
    } else {
      return '${date.hour}h${date.minute}m';
    }
  }

  DateTime strSeconds(int time) {
    final Duration duration = Duration(seconds: time);
    final DateTime now = DateTime.now();
    final DateTime startOfDay = DateTime(now.year, now.month, 1, 0, 0, 0);
    final DateTime result = startOfDay.add(duration);
    return result;
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

  setAdd({required RequisitionOverTime value, required int index}) {
    setState(() {
      requisitionOverTimes[index] = value;
    });
  }

  PostRequestRequest request() {
    return widget.requestId.isEmpty
        ? PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
              description: description,
              overTimes: requisitionOverTimes,
            ),
          )
        : PostRequestRequest(
            id: widget.requestId,
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
              description: description,
              overTimes: requisitionOverTimes,
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

  setDescription(String value) {
    setState(() {
      description = value;
    });
  }

  _cancel(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  _setFollower(List<User> value) {
    setState(() {
      followers = value.map((e) => e.id).toList();
    });
  }

  List<User> _setListUser(List<User> userById) {
    if (widget.requestId.isNotEmpty) {
      return userById;
    }
    return [];
  }

  _setChangeRequisitionOverTimes(List<RequisitionOverTime> value) {
    setState(() {
      requisitionOverTimes = value;
    });
  }

  _changeTypeContainer(List<bool> value) {
    setState(() {
      checkTypeContainer = value;
    });
  }

  addOverTime() {
    setState(() {
      checkTypeContainer.add(true);
      requisitionOverTimes.add(RequisitionOverTime(date: DateTime.now()));
    });
  }
}
