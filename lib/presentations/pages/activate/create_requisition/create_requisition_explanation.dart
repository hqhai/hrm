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
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/list_overtime.dart';
import 'package:base_app/presentations/widgets/custom/app_button_add_list.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/timekeeping_dialog/timekeeping_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequestExplanationPageRoute = GoRoute(
  path: Pages.createRequestExplanationPage,
  name: Pages.createRequestExplanationPage,
  builder: (context, GoRouterState state) {
    Map data = state.extra as Map;
    return CreateRequisitionExplanationPage(
      flowId: data['flowId'],
      requestId: data['requestId'],
      type: data['type'],
    );
  },
);

class CreateRequisitionExplanationPage extends StatefulWidget {
  const CreateRequisitionExplanationPage({
    super.key,
    this.flowId = '',
    this.requestId,
    this.type = RequisitionTypeEnum.explanation,
  });

  final RequisitionTypeEnum type;
  final String flowId;
  final String? requestId;

  @override
  State<CreateRequisitionExplanationPage> createState() => _CreateRequisitionExplanationPageState();
}

class _CreateRequisitionExplanationPageState extends State<CreateRequisitionExplanationPage> {
  final TextEditingController detailedDescriptionController = TextEditingController();
  List<RequisitionOverTime> listRequisitionOverTimes = [];
  String errorTime = '', errorDestination = '';
  String? description;
  List<String> followers = [];
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;
  bool checkClick = false;

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
    setState(() {
      listRequisitionOverTimes = [...?state.requisition.config.overTimes];
      followers = [...state.requisition.followerIds];
      description = state.requisition.config.description;
      detailedDescriptionController.text = description ?? "";
    });
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
      listenWhen: (previous, current) => _listenWhen(previous, current),
      builder: (context, state) => BlocBuilder<UserByIdBloc, UserByIdState>(
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
                          ListOverTime(
                            checkExplanation: true,
                            title: appLocalizations.timeKeepingList,
                            error: errorTime,
                            requisitionOverTimes: listRequisitionOverTimes,
                            onChangeList: (value) => _setChangeRequisitionOverTimes(value),
                          ),
                          ButtonAddList(
                            title: appLocalizations.addWorkTime,
                            callBack: () => _addTime(context),
                          ),
                          ItemCreateInputArea(
                            error: errorDestination,
                            textController: detailedDescriptionController,
                            title: appLocalizations.detailedDescription,
                            onChange: (value) => _setDetailedDescription(value),
                          ),
                          ItemCreateFollower(
                              listFollower: _setListUser(
                                stateUserById.userById,
                              ),
                              title: appLocalizations.follower,
                              onChange: (value) => _setFollower(value)),
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

  List<User> _setListUser(List<User> userById) {
    if (widget.requestId != null) {
      return userById;
    }
    return [];
  }

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkDescription = description != null;
    final bool checkList = listRequisitionOverTimes.isNotEmpty;
    setState(() {
      errorTime = checkList ? '' : appLocalizations.cannotBeLeftBlank;
      errorDestination = checkDescription ? '' : appLocalizations.cannotBeLeftBlank;
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
    });
  }

  PostRequestRequest request() {
    return widget.requestId == null
        ? PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              editTimekeeping: EditTimekeeping.editTimekeeping,
              overTimes: listRequisitionOverTimes,
              description: description,
            ),
          )
        : PostRequestRequest(
            id: widget.requestId,
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              editTimekeeping: EditTimekeeping.editTimekeeping,
              overTimes: listRequisitionOverTimes,
              description: description,
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

  _listenWhen(RequisitionState previous, RequisitionState current) {
    return previous.requisition != current.requisition;
  }

  _addTime(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: TimeKeepingDialog(
            onChangeOverTimes: (value) => setListTime(value),
          ),
        );
      },
    );
  }

  setListTime(RequisitionOverTime value) {
    setState(() {
      listRequisitionOverTimes.add(value);
    });
  }

  _cancel() {}

  _setChangeRequisitionOverTimes(List<RequisitionOverTime> value) {
    setState(() {
      listRequisitionOverTimes = value;
    });
  }
}
