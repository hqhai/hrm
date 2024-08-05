import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_request_model.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_time_keeping_type.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_common/item_time.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/list_overtime.dart';
import 'package:base_app/presentations/widgets/custom/app_button_add_list.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/overtime/over_time_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
  String errorTime = '', errorDestination = '';
  List<RequisitionOverTime> listRequisitionOverTimes = [];
  DateTime? workDate;
  String? description;
  List<String> followers = [];
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;
  bool checkClick = false;
  EditTimekeeping type = EditTimekeeping.late;

  @override
  void initState() {
    if (widget.requestId.isNotEmpty) {
      final request = dI<RequisitionBloc>().state.requisition;
      workDate = request.config.startDate;
      description = request.config.description ?? "";
      detailedDescriptionController.text = description ?? "";
      listRequisitionOverTimes = [...?request.config.overTimes];
      followers = [...request.followerIds];
    }
    super.initState();
  }

  double opacity() {
    bool check = checkLoad == false && checkSuccess == false && checkUnSuccess == false;
    return check ? 1 : 0.3;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<UserByIdBloc, UserByIdState>(
  builder: (context, stateUserById) {
    return BlocBuilder<RequisitionBloc, RequisitionState>(
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
        body: Stack(
          children: [
            Opacity(
              opacity: opacity(),
              child: SingleChildScrollView(
                child: ContainerScreenMain(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ItemCreateTimeKeepingType(
                        typeDefault: EditTimekeeping.early,
                        onChange: (value) => _setType(value),
                      ),
                      ItemTime(
                        title: '${appLocalizations.time} ${appLocalizations.lateOrEarly}',
                        setTime: (value) => _setWorkDate(value),
                        timeOld: workDate ?? DateTime.now(),
                      ),
                      ItemCreateInputArea(
                        error: errorDestination,
                        textController: detailedDescriptionController,
                        title: appLocalizations.detailedDescription,
                        onChange: (value) => _setDetailedDescription(value),
                      ),
                      if (type == EditTimekeeping.early)
                        ListOverTime(
                          title: appLocalizations.listTime,
                          requisitionOverTimes: listRequisitionOverTimes,
                          onChangeList: (value) => _setChangeRequisitionOverTimes(value),
                        ),
                      if (type == EditTimekeeping.early)
                        ButtonAddList(
                          title: appLocalizations.workOffset,
                          callBack: () => _addOverTime(context),
                        ),
                      ItemCreateFollower(
                        listFollower: _setListUser(stateUserById.userById),
                          title: appLocalizations.follower,
                          onChange: (value) => _setFollower(value)),
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
      ),
    );
  },
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

  _addOverTime(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: OverTimeAddDialog(
            checkNote: false,
            onChangeOverTimes: (value) => setAdd(value),
          ),
        );
      },
    );
  }

  setAdd(RequisitionOverTime value) {
    setState(() {
      listRequisitionOverTimes.add(value);
    });
  }

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkDescription = description != null;
    setState(() {
      errorDestination = checkDescription ? '' : appLocalizations.cannotBeLeftBlank;
    });
    return checkDescription;
  }

  _setFollower(List<User> value) {
    setState(() {
      followers = value.map((e) => e.id).toList();
    });
  }

  PostRequestRequest request() {
    return widget.requestId.isEmpty
        ? PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              explanationReason: type,
              startDate: workDate,
              overTimes: listRequisitionOverTimes,
              description: description,
            ),
          )
        : PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              explanationReason: type,
              startDate: workDate,
              overTimes: listRequisitionOverTimes,
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

  _cancel() {}

  _setWorkDate(DateTime value) {
    setState(() {
      workDate = value;
    });
  }

  setListTime(RequisitionOverTime value) {
    setState(() {
      listRequisitionOverTimes.add(value);
    });
  }

  _setDetailedDescription(String value) {
    setState(() {
      description = value;
    });
  }

  _setChangeRequisitionOverTimes(List<RequisitionOverTime> value) {
    setState(() {
      listRequisitionOverTimes = value;
    });
  }

  _setType(EditTimekeeping value) {
    setState(() {
      type = value;
    });
  }
}
