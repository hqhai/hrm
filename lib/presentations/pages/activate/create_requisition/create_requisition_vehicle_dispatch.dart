import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_request_model.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create_interval_on_leave.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
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
  String errorTime = '', errorSchedule = '', errorContent = '';
  String? startTime, endTime, description, content;

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
    if (state.status == RequisitionEnum.success) {
      setState(() {
        content = state.requisition.config.content ?? "";
        contentController.text = state.requisition.config.content ?? "";
        subtitudePersons = state.requisition.config.subtitudePersons ?? [];
        description = state.requisition.config.description ?? "";
        descriptionController.text = state.requisition.config.description ?? "";
        startTime = formatYMDHMS(state.requisition.config.startDate ?? "");
        endTime = formatYMDHMS(state.requisition.config.endDate ?? "");
        followers = state.requisition.followerIds;
      });
    }
  }

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkTime = totalMinute > 0;
    final DateTime date = DateTime.parse(
      startTime ?? DateTime.now().toString(),
    );
    final bool checkStart = date.difference(DateTime.now()).inHours > 0;
    final bool checkDescription = description != '' && description != null;
    final bool checkContent = content != '' && content != null;
    final bool check = checkDescription && checkContent && subtitudePersons != [];
    setState(() {
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

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocListener<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(context, state),
      listenWhen: (previous, current) => previous.requisition != current.requisition,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            RequisitionTypeEnum.vehicleDriver.configTypeName,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x5,
            ),
          ),
        ),
        body: SingleChildScrollView(
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
                ItemCreateIntervalOnLeave(
                  endTimeOld: endTime,
                  startTimeOld: startTime,
                  error: errorTime,
                  dayOrHours: false,
                  title: appLocalizations.intervalOnLeave,
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
                  title: appLocalizations.content,
                  onChange: (value) => _setContent(value),
                ),
                ItemCreateFollower(
                    title: appLocalizations.walker, onChange: (value) => _setWalker(value)),
                ItemCreateFollower(
                    title: appLocalizations.follower, onChange: (value) => _setFollower(value)),
                ItemButton(
                  callbackSave: () => _save(context),
                  callbackCancel: () => _cancel(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
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

  setStartTime(String value) {
    setState(() {
      startTime = value;
    });
  }

  setEndTime(String value) {
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

  _save(BuildContext context) async {
    if (_checkValue(context)) {
      progressIndicatorDialog(context);
      final Completer completer = Completer<RequisitionEnum>();
      dI<RequisitionBloc>().add(
        PostRequestEvent(
          completer: completer,
          postRequestRequest: PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              description: descriptionController.text,
              content: contentController.text,
              endDate: formatIso8601(endTime),
              startDate: formatIso8601(startTime),
              subtitudePersons: subtitudePersons,
            ),
          ),
        ),
      );
      final status = await completer.future;
      if (status == RequisitionEnum.success) {
        if (!context.mounted) return;
        Navigator.of(context).pop();
        successDialog(context);
      }
      if (status == RequisitionEnum.fail) {
        if (!context.mounted) return;
        Navigator.of(context).pop();
        unsuccessfulDialog(context);
      }
    }
  }

  _cancel(BuildContext context) {
    popDialog(context);
  }

  setTotal(int value) {
    setState(() {
      totalMinute = value;
    });
  }
}
