import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
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
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/list_overtime.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/total_time.dart';
import 'package:base_app/presentations/widgets/custom/app_button_add_list.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/overtime/over_time_dialog.dart';
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
    this.requestId,
  });

  final String flowId;
  final String? requestId;

  @override
  State<CreateRequisitionOverTimePage> createState() => _CreateRequisitionOverTimePageState();
}

class _CreateRequisitionOverTimePageState extends State<CreateRequisitionOverTimePage> {
  List<RequisitionOverTime> requisitionOverTimes = [];
  List<String> followers = [];
  String description = "";
  String error = '', errorDescription = '';
  bool checkLoad = false, checkSuccess = false, checkUnSuccess = false;
  final TextEditingController inputController = TextEditingController();

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
    final bool check = requisitionOverTimes.isNotEmpty;
    final bool checkDescription = description.isNotEmpty;
    setState(() {
      error = check ? '' : appLocalizations.thereAreCurrentlyNoProducts;
      errorDescription = checkDescription ? '' : appLocalizations.cannotBeLeftBlank;
    });
    return check && checkDescription;
  }

  _listener(BuildContext context, RequisitionState state) {
    if (state.statusGetById == RequisitionEnum.success&& widget.requestId != null) {
      setState(() {
        followers = state.requisition.followerIds;
        requisitionOverTimes = [...?state.requisition.config.overTimes];
        description = state.requisition.config.description ?? "";
        inputController.text = description;
        dI<UserByIdBloc>().add(GetUsersByIdEvent(ids: state.requisition.followerIds));
      });
    }
  }

  bool _listenWhen(RequisitionState statusP, RequisitionState statusC) {
    return statusP.requisition != statusC.requisition;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(context, state),
      listenWhen: (previous, current) => _listenWhen(previous, current),
      builder: (context, state) => BlocBuilder<UserByIdBloc, UserByIdState>(
        builder: (context, stateUserById) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                RequisitionTypeEnum.overTime.configTypeName,
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
                    width: width,
                    height: height * 0.85,
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ItemCreateInputArea(
                            title: appLocalizations.reason,
                            error: errorDescription,
                            textController: inputController,
                            onChange: (value) => setDescription(value),
                          ),
                          ListOverTime(
                            title: appLocalizations.listOvertime,
                            error: error,
                            requisitionOverTimes: requisitionOverTimes,
                            onChangeList: (value) => _setChangeRequisitionOverTimes(value),
                          ),
                          ButtonAddList(
                            title: appLocalizations.overtime,
                            callBack: () => _addOverTime(context),
                          ),
                          TotalTime(
                            title: appLocalizations.totalTime,
                            content: timeDHM(_totalAmount().toInt()),
                          ),
                          ItemCreateFollower(
                              listFollower: _setListUser(
                                stateUserById.userById,
                              ),
                              title: appLocalizations.follower,
                              onChange: (value) => _setFollower(value)),
                          Padding(
                            padding: const EdgeInsets.only(top: SpacingUnit.x3_5),
                            child: ItemButton(
                              callbackSave: () => _save(context),
                              callbackCancel: () => _cancel(),
                            ),
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

  _addOverTime(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: OverTimeAddDialog(
            onChangeOverTimes: (value) => setAdd(value),
          ),
        );
      },
    );
  }

  setAdd(RequisitionOverTime value) {
    setState(() {
      requisitionOverTimes.add(value);
    });
  }

  _save(BuildContext context) async {
    if (_checkValue(context) && widget.requestId != null) {
      Completer completer = Completer<RequisitionEnum>();
      dI<RequisitionBloc>().add(
        EditRequestEvent(
          completer: completer,
          postRequestRequest: PostRequestRequest(
            id: widget.requestId,
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              description: description,
              overTimes: requisitionOverTimes,
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
    } else if (_checkValue(context) && widget.requestId == null) {
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
              description: description,
              overTimes: requisitionOverTimes,
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

  setDescription(String value) {
    setState(() {
      description = value;
    });
  }

  double _subtotal() {
    double subtotal = 0;
    for (var element in requisitionOverTimes) {
      subtotal += element.suggestTime ?? 0;
    }
    return subtotal;
  }

  double _numberValue() {
    return _subtotal() * 0.08;
  }

  double _totalAmount() {
    return _subtotal() + _numberValue();
  }

  _cancel() {}

  _setFollower(List<User> value) {
    setState(() {
      followers = value.map((e) => e.id).toList();
    });
  }

  List<User> _setListUser(List<User> userById) {
    if (widget.requestId != null) {
      return userById;
    }
    return [];
  }

  _setChangeRequisitionOverTimes(List<RequisitionOverTime> value) {
    setState(() {
      requisitionOverTimes = value;
    });
  }
}
