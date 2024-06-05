import 'dart:io';

import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/business/item_create_business.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_load_flie.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequisitionBusinessPageRoute = GoRoute(
  path: Pages.createRequisitionBusinessPage,
  name: Pages.createRequisitionBusinessPage,
  builder: (context, GoRouterState state) => const CreateRequisitionBusinessPage(),
);

class CreateRequisitionBusinessPage extends StatefulWidget {
  const CreateRequisitionBusinessPage({super.key});

  @override
  State<CreateRequisitionBusinessPage> createState() => _CreateRequisitionBusinessPageState();
}

class _CreateRequisitionBusinessPageState extends State<CreateRequisitionBusinessPage> {
  final TextEditingController detailedDescriptionController = TextEditingController(),
      vehicleController = TextEditingController(),
      destinationController = TextEditingController();
  int totalMinute = 0;
  String startTime = '', endTime = '', reason = '', vehicle = '', destination = '';
  List<File> files = [];
  List<String> followers = [], substitutes = [];
  RequisitionTypeOnLeaveEnum? reasonForOnLeave = RequisitionTypeOnLeaveEnum.sickLeave;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RequisitionTypeEnum.business.configTypeName,
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
                title: appLocalizations.workingTime,
                startTime: (value) => setStartTime(value),
                endTime: (value) => setEndTime(value),
              ),
              ItemCreateInputArea(
                textController: detailedDescriptionController,
                title: appLocalizations.detailedDescription,
                onChange: (value) => _setReason(value),
              ),
              ItemCreateFollower(
                  title: appLocalizations.substitute, onChange: (value) => _setSubstitute(value)),
              ItemCreateFollower(
                  title: appLocalizations.follower, onChange: (value) => _setFollower(value)),
              ItemCreateInput(
                title: appLocalizations.vehicle,
                inputController: vehicleController,
                onChange: (value) => _setVehicle(value),
              ),
              ItemCreateInput(
                title: appLocalizations.destination,
                inputController: destinationController,
                onChange: (value) => _setDestination(value),
              ),
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

  _setFollower(List<String> value) {
    setState(() {
      followers = value;
    });
  }

  _setReason(String value) {
    setState(() {
      reason = value;
    });
  }

  _setFile(List<File> value) {
    setState(() {
      files = value;
    });
  }

  _save() {}

  _cancel() {}

  _setSubstitute(List<String> value) {
    setState(() {
      substitutes = value;
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
}
