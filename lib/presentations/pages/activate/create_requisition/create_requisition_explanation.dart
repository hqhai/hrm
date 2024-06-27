import 'dart:async';
import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/routers/pages.dart';
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
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/item_list_over_time.dart';
import 'package:base_app/presentations/widgets/custom/app_button_add_list.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/timekeeping_dialog/timekeeping_dialog.dart';
import 'package:collection/collection.dart';
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
  List<File> files = [];
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

  _listener(BuildContext context, RequisitionState state) {
    setState(() {
      listRequisitionOverTimes = [...?state.requisition.config.overTimes];
      followers = [...state.requisition.followerIds];
      description = state.requisition.config.description;
      detailedDescriptionController.text = description ?? "";
      dI<UserByIdBloc>().add(GetUsersByIdEvent(ids: state.requisition.followerIds));
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
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
                        Text(
                          appLocalizations.timeKeepingList,
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x4,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (errorTime != '')
                          Text(
                            errorTime,
                            style: TextStyle(
                              color: colors.error,
                              fontSize: SpacingUnit.x3,
                            ),
                          ),
                        if (listRequisitionOverTimes.isNotEmpty)
                          Container(
                            width: width,
                            padding: const EdgeInsets.all(SpacingUnit.x1),
                            margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                            decoration: BoxDecoration(
                              color: colors.surface,
                              borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
                            ),
                            child: Column(
                              children: listRequisitionOverTimes
                                  .mapIndexed(
                                    (index, element) => GestureDetector(
                                      onTap: () => _getStationeryInList(
                                          context, listRequisitionOverTimes[index], index),
                                      child: ItemListOverTime(
                                        requisitionOverTime: listRequisitionOverTimes[index],
                                        index: index,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
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
              editTimekeeping: EditTimekeeping.editTimekeeping,
              overTimes: listRequisitionOverTimes,
              destination: description,
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
            id: widget.requestId,
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              editTimekeeping: EditTimekeeping.editTimekeeping,
              overTimes: listRequisitionOverTimes,
              destination: description,
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

  _listenWhen(RequisitionState previous, RequisitionState current) {
    return previous.requisition != current.requisition;
  }

  _addTime(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: TimeKeepingDialog(
            onChange: (value) => setListTime(value),
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

  _getStationeryInList(
      BuildContext context, RequisitionOverTime listRequisitionOverTime, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: TimeKeepingDialog(
            requisitionOverTime: listRequisitionOverTime,
            onChange: (value) => setListTime(value),
          ),
        );
      },
    );
  }

  _cancel() {}
}
