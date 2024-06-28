import 'dart:async';

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
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_timm_ymd.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/list_overtime.dart';
import 'package:base_app/presentations/widgets/custom/app_button_add_list.dart';
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
    this.requestId,
    this.type = RequisitionTypeEnum.lateArrival,
  });

  final RequisitionTypeEnum type;
  final String flowId;
  final String? requestId;

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

  @override
  void initState() {
    if (widget.requestId?.isNotEmpty ?? false) {
      dI<RequisitionBloc>().add(
        GetRequisitionByIdEvent(id: widget.requestId),
      );
    }
    super.initState();
  }

  _listener(BuildContext context, RequisitionState state) {}

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(context, state),
      listenWhen: (previous, current) => _listenWhen(previous, current),
      builder: (context, state) => Scaffold(
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
                    ItemCreateInputArea(
                      error: errorDestination,
                      textController: detailedDescriptionController,
                      title: appLocalizations.detailedDescription,
                      onChange: (value) => _setDetailedDescription(value),
                    ),
                    ItemCreateTimeYMD(
                      check: true,
                      title: appLocalizations.workDay,
                      dateOfBirth: DateTime.now(),
                      onChangeDateOfBirth: (value) => _setWorkDate(value),
                    ),
                    if (widget.type == RequisitionTypeEnum.earlyDeparture)
                      ListOverTime(
                        title: appLocalizations.listTime,
                        requisitionOverTimes: listRequisitionOverTimes,
                        onChangeList: (value) => _setChangeRequisitionOverTimes(value),
                      ),
                    if (widget.type == RequisitionTypeEnum.earlyDeparture)
                      ButtonAddList(
                        title: appLocalizations.workOffset,
                        callBack: () => _addOverTime(context),
                      ),
                    ItemCreateFollower(
                        title: appLocalizations.follower, onChange: (value) => _setFollower(value)),
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
      listRequisitionOverTimes.add(value);
    });
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
              explanationReason: explanationReason(),
              startDate: workDate,
              overTimes: listRequisitionOverTimes,
              description: description,
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
              explanationReason: explanationReason(),
              startDate: workDate,
              overTimes: listRequisitionOverTimes,
              description: description,
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

  String explanationReason() {
    if (widget.type == RequisitionTypeEnum.lateArrival) {
      return EditTimekeeping.late.name;
    }
    return EditTimekeeping.early.name;
  }

  _cancel() {}

  _setWorkDate(DateTime value) {
    setState(() {
      workDate = value;
    });
  }

  _listenWhen(RequisitionState previous, RequisitionState current) {
    return previous != current;
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
}
