import 'dart:io';

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
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create_interval_on_leave.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/success_or_unsuccess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequestBusinessPageRoute = GoRoute(
    path: Pages.createRequestBusinessPage,
    name: Pages.createRequestBusinessPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return CreateRequisitionBusinessPage(
        flowId: data['flowId'],
      );
    });

class CreateRequisitionBusinessPage extends StatefulWidget {
  const CreateRequisitionBusinessPage({super.key, this.flowId = ''});

  final String flowId;

  @override
  State<CreateRequisitionBusinessPage> createState() => _CreateRequisitionBusinessPageState();
}

class _CreateRequisitionBusinessPageState extends State<CreateRequisitionBusinessPage> {
  final TextEditingController detailedDescriptionController = TextEditingController(),
      vehicleController = TextEditingController(),
      destinationController = TextEditingController(),
      contentController = TextEditingController();
  double total = 0;
  String errorTime = '', errorReason = '', errorContent = '', errorVehicle = '', errorDestination = '';
  String startTime = '', endTime = '', content = '', reason = '', vehicle = '', destination = '';
  List<File> files = [];
  List<String> followers = [], substitutes = [];
  RequisitionTypeOnLeaveEnum? reasonForOnLeave = RequisitionTypeOnLeaveEnum.sickLeave;

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    bool checkTime = total > 0;
    bool check = reason != '' && vehicle != '' && destination != '' && content != '';
    setState(() {
      errorTime = checkTime ? "" : appLocalizations.endTimeMustBeAfterStartTime;
      errorReason = reason != '' ? '' : appLocalizations.cannotBeLeftBlank;
      errorContent = content != '' ? '' : appLocalizations.cannotBeLeftBlank;
      errorVehicle = vehicle != '' ? '' : appLocalizations.cannotBeLeftBlank;
      errorDestination = destination != '' ? '' : appLocalizations.cannotBeLeftBlank;
    });
    return check;
  }

  _listener(BuildContext context, RequisitionState state) {
    if (state.status == RequisitionEnum.postRequisitionInit) {
      progressIndicatorDialog(context);
    } else if (state.status == RequisitionEnum.postRequisitionSuccess) {
      Navigator.of(context).pop();
      successDialog(context);
    } else if (state.status == RequisitionEnum.postRequisitionError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RequisitionTypeEnum.bussiness.configTypeName,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
      body: BlocListener<RequisitionBloc, RequisitionState>(
        listener: (context, state) => _listener(context, state),
        child: SingleChildScrollView(
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
                  error: errorTime,
                  dayOrHours: false,
                  title: appLocalizations.intervalOnLeave,
                  startTime: (value) => setStartTime(value),
                  endTime: (value) => setEndTime(value),
                  total: (value) => setTotal(value),
                ),
                ItemCreateInputArea(
                  error: errorDestination,
                  textController: detailedDescriptionController,
                  title: appLocalizations.detailedDescription,
                  onChange: (value) => _setReason(value),
                ),
                ItemCreateInputArea(
                  error: errorContent,
                  textController: contentController,
                  title: appLocalizations.content,
                  onChange: (value) => _setContent(value),
                ),
                ItemCreateFollower(
                    title: appLocalizations.substitute, onChange: (value) => _setSubstitute(value)),
                ItemCreateFollower(
                    title: appLocalizations.follower, onChange: (value) => _setFollower(value)),
                ItemCreateInput(
                  error: errorVehicle,
                  title: appLocalizations.vehicle,
                  inputController: vehicleController,
                  onChange: (value) => _setVehicle(value),
                ),
                ItemCreateInput(
                  error: errorDestination,
                  title: appLocalizations.destination,
                  inputController: destinationController,
                  onChange: (value) => _setDestination(value),
                ),
                ItemButton(
                  callbackSave: () => _save(context),
                  callbackCancel: () => _cancel(),
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

  _setReason(String value) {
    setState(() {
      reason = value;
    });
  }

  _save(BuildContext context) {
    if (_checkValue(context)) {
      dI<RequisitionBloc>().add(
        PostRequestEvent(
          postRequestRequest: PostRequestRequest(
            description: detailedDescriptionController.text,
            followerIds: followers,
            flowId: widget.flowId,
            config: ConfigRequestModel(
              destination: destinationController.text,
              content: contentController.text,
              vehicle: vehicleController.text,
              endDate: endTime,
              startDate: startTime,
              subtitudePersons: substitutes,
              total: total,
            ),
          ),
        ),
      );
    }
  }

  _cancel() {}

  _setSubstitute(List<User> value) {
    setState(() {
      substitutes = value.map((e) => e.id).toList();
    });
  }

  setStartTime(String value) {
    setState(() {
      startTime = formatIso8601(value);
    });
  }

  setEndTime(String value) {
    setState(() {
      endTime = formatIso8601(value);
    });
  }

  _setVehicle(String value) {
    setState(() {
      vehicle = value;
    });
  }

  _setDestination(String value) {
    setState(() {
      destination = value;
    });
  }

  _setContent(String value) {
    setState(() {
      content = value;
    });
  }

  setTotal(int value) {
    setState(() {
      total = double.parse(value.toString());
    });
  }
}
