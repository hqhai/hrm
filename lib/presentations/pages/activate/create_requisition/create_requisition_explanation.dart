import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_model_request.dart';
import 'package:base_app/data/models/requisition/requisition/explanation.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_list_explanations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
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
    this.requestId = '',
    this.type = RequisitionTypeEnum.explanation,
  });

  final RequisitionTypeEnum type;
  final String flowId;
  final String requestId;

  @override
  State<CreateRequisitionExplanationPage> createState() => _CreateRequisitionExplanationPageState();
}

class _CreateRequisitionExplanationPageState extends State<CreateRequisitionExplanationPage> {
  final TextEditingController detailedDescriptionController = TextEditingController();
  List<RequisitionOverTime> listRequisitionOverTimes = [];
  String errorTime = '', errorDestination = '', errorDialog = '', errorExplanations = '';
  String? description;
  List<String> followers = [];
  List<Explanation> explanations = [];
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;
  bool checkClick = false;

  @override
  void initState() {
    if (widget.requestId.isNotEmpty) {
      final request = dI<RequisitionBloc>().state.requisition;
      listRequisitionOverTimes = [...?request.config.overTimes];
      followers = [...request.followerIds];
      description = request.config.description;
      detailedDescriptionController.text = description ?? "";
      explanations = [...request.config.explanations];
    }
    super.initState();
  }

  double opacity() {
    bool check = checkLoad == false && checkSuccess == false && checkUnSuccess == false;
    return check ? 1 : 0.3;
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
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(state.errorCode),
      builder: (context, state) => BlocBuilder<UserByIdBloc, UserByIdState>(
        builder: (context, stateUserById) {
          return Scaffold(
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
                    ListExplanationsWidget(
                      error: errorExplanations,
                      changeExplanations: (value) => _setExplanations(value),
                      explanations: explanations,
                      title: appLocalizations.workDay,
                      callback: () => _addExplanation(),
                    ),
                    ItemCreateInputArea(
                      requiredValidate: true,
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

  List<User> _setListUser(List<User> userById) {
    if (widget.requestId.isNotEmpty) {
      return userById;
    }
    return [];
  }

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkDescription = description != null;
    final bool checkList = explanations.isNotEmpty;
    setState(() {
      errorTime = checkList ? '' : appLocalizations.cannotBeLeftBlank;
      errorDestination = checkDescription ? '' : appLocalizations.cannotBeLeftBlank;
      errorExplanations = checkList ? '' : appLocalizations.notSelectedAShift;
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
    return widget.requestId.isEmpty
        ? PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
                explanationReason: EditTimekeeping.editTimekeeping,
                description: description,
                explanations: explanations),
          )
        : PostRequestRequest(
            id: widget.requestId,
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigModelRequest(
              explanationReason: EditTimekeeping.editTimekeeping,
              description: description,
              explanations: explanations,
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

  _setExplanations(List<Explanation> value) {
    setState(() {
      explanations = value;
    });
  }

  _addExplanation() {
    setState(() {
      explanations.add(
        Explanation(workDate: DateTime.now()),
      );
    });
  }
}
