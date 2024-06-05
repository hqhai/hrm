import 'dart:io';

import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_load_flie.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create_interval_on_leave.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create_reason_on_leave.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequisitionLeavePageRoute = GoRoute(
  path: Pages.createRequisitionLeavePage,
  name: Pages.createRequisitionLeavePage,
  builder: (context, GoRouterState state) => const CreateRequisitionLeavePage(),
);

class CreateRequisitionLeavePage extends StatefulWidget {
  const CreateRequisitionLeavePage({super.key});

  @override
  State<CreateRequisitionLeavePage> createState() => _CreateRequisitionLeavePageState();
}

class _CreateRequisitionLeavePageState extends State<CreateRequisitionLeavePage> {
  final TextEditingController detailedDescriptionController = TextEditingController(),
      detailedReasonController = TextEditingController();
  int totalMinute = 0;
  String startTime = '', endTime = '', reason = '', detailedDescription = '', detailedReason = '';
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
          RequisitionTypeEnum.leave.configTypeName,
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
              ItemCreateReasonOnLeave(
                onChange: (value) => _setReasonOnLeave(value),
              ),
              ItemCreateIntervalOnLeave(
                dayOrHours: false,
                title: appLocalizations.intervalOnLeave,
                startTime: (value) => setStartTime(value),
                endTime: (value) => setEndTime(value),
              ),
              if (_checkType())
                ItemCreateInputArea(
                  textController: detailedReasonController,
                  title: appLocalizations.detailedReason,
                  onChange: (value) => _setDetailedReason(value),
                ),
              ItemCreateFollower(
                  title: appLocalizations.substitute, onChange: (value) => _setSubstitute(value)),
              ItemCreateFollower(
                  title: appLocalizations.follower, onChange: (value) => _setFollower(value)),
              ItemLoadFile(onChangeFiles: (value) => _setFile(value)),
              ItemCreateInputArea(
                textController: detailedDescriptionController,
                title: appLocalizations.detailedDescription,
                onChange: (value) => _setReason(value),
              ),
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

  bool _checkType() {
    return reasonForOnLeave == RequisitionTypeOnLeaveEnum.otherPaidLeave ||
        reasonForOnLeave == RequisitionTypeOnLeaveEnum.leaveWithoutPay ||
        reasonForOnLeave == RequisitionTypeOnLeaveEnum.other;
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

  _setReasonOnLeave(RequisitionTypeOnLeaveEnum value) {
    setState(() {
      reasonForOnLeave = value;
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

  _setDetailedReason(String value) {
    setState(() {
      detailedReason = value;
    });
  }
}
