import 'dart:io';

import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/business/item_create_business.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_load_flie.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequestVehicleDispatchPageRoute = GoRoute(
  path: Pages.createRequestVehicleDispatchPage,
  name: Pages.createRequestVehicleDispatchPage,
  builder: (context, GoRouterState state) => const CreateRequestVehicleDispatchPage(),
);

class CreateRequestVehicleDispatchPage extends StatefulWidget {
  const CreateRequestVehicleDispatchPage({super.key});

  @override
  State<CreateRequestVehicleDispatchPage> createState() =>
      _CreateRequestVehicleDispatchPageState();
}

class _CreateRequestVehicleDispatchPageState
    extends State<CreateRequestVehicleDispatchPage> {
  final TextEditingController scheduleController = TextEditingController(),
      vehicleController = TextEditingController(),
      destinationController = TextEditingController();
  int totalMinute = 0;
  String startTime = '', endTime = '', schedule = '';
  List<File> files = [];
  List<User> followers = [], walkers = [], carCaller = [];
  RequisitionTypeOnLeaveEnum? scheduleForOnLeave = RequisitionTypeOnLeaveEnum.sickLeave;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
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
              ItemCreateBusinessDay(
                dayOrHours: true,
                title: appLocalizations.time,
                startTime: (value) => setStartTime(value),
                endTime: (value) => setEndTime(value),
              ),
              ItemCreateInputArea(
                textController: scheduleController,
                title: appLocalizations.schedule,
                onChange: (value) => _setSchedule(value),
              ),
              ItemCreateFollower(
                  title: appLocalizations.walker, onChange: (value) => _setWalker(value)),
              ItemCreateFollower(
                  title: appLocalizations.carCaller, onChange: (value) => _setCarCaller(value)),
              ItemCreateFollower(
                  title: appLocalizations.follower, onChange: (value) => _setFollower(value)),
              ItemLoadFile(onChangeFiles: (value) => _setFile(value)),
              ItemButton(
                callbackSave: () => _save(),
                callbackCancel: () => _cancel(),
              )
            ],
          ),
        ),
      ),
    );
  }

  _setFollower(List<User> value) {
    setState(() {
      followers = value;
    });
  }

  _setFile(List<File> value) {
    setState(() {
      files = value;
    });
  }

  _save() {}

  _cancel() {}

  _setWalker(List<User> value) {
    setState(() {
      walkers = value;
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
      schedule = value;
    });
  }

  _setCarCaller(List<User> value) {
    setState(() {
      carCaller = value;
    });
  }
}
