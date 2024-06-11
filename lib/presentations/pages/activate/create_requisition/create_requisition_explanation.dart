import 'dart:io';

import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/profile/item_date_of_birth_update_profile.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_load_flie.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_application_code.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_reason_for_explanation.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_total_minute.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

final createRequestExplanationPageRoute = GoRoute(
  path: Pages.createRequestExplanationPage,
  name: Pages.createRequestExplanationPage,
  builder: (context, GoRouterState state) => const CreateRequisitionExplanationPage(),
);

class CreateRequisitionExplanationPage extends StatefulWidget {
  const CreateRequisitionExplanationPage({super.key});

  @override
  State<CreateRequisitionExplanationPage> createState() => _CreateRequisitionExplanationPageState();
}

class _CreateRequisitionExplanationPageState extends State<CreateRequisitionExplanationPage> {
  final TextEditingController totalMinuteController = TextEditingController(),
      reasonController = TextEditingController(),
      detailedDescriptionController = TextEditingController(),
      applicationCodeController = TextEditingController();
  int totalMinute = 0;
  String reason = '',
      detailedDescription = '',
      replaceDate = '',
      applicationCode = '',
      workDate = '';
  List<User> followers = [];
  List<File> files = [];
  RequisitionTypeExplanationEnum? reasonForExplanation = RequisitionTypeExplanationEnum.late;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RequisitionTypeEnum.explanation.configTypeName,
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
              if (reasonForExplanation == RequisitionTypeExplanationEnum.late ||
                  reasonForExplanation == RequisitionTypeExplanationEnum.leaveEarly)
                ItemCreateTotalMinute(
                  title: appLocalizations.totalMinute,
                  totalMinuteController: totalMinuteController,
                  onChange: (value) => _setTotalMinute(value),
                ),
              ItemCreateReasonForExplanation(
                onChange: (value) => _setReasonForExplanation(value),
              ),
              ItemCreateInputArea(
                textController: reasonController,
                title: appLocalizations.reason,
                onChange: (value) => _setReason(value),
              ),
              ItemCreateInputArea(
                textController: detailedDescriptionController,
                title: appLocalizations.detailedDescription,
                onChange: (value) => _setDetailedDescription(value),
              ),
              if (reasonForExplanation == RequisitionTypeExplanationEnum.leaveCorrection)
                ItemCreateInputApplicationCode(
                  textController: applicationCodeController,
                  onChange: (value) => _setApplicationCode(value),
                ),
              if (reasonForExplanation == RequisitionTypeExplanationEnum.leaveEarly)
                ItemDateOfBirthUpdateProfile(
                  check: true,
                  title: appLocalizations.replaceDay,
                  dateOfBirth: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                  onChangeDateOfBirth: (value) => _setDate(value),
                ),
              if (reasonForExplanation == RequisitionTypeExplanationEnum.editTimekeeping)
                ItemDateOfBirthUpdateProfile(
                  check: true,
                  title: appLocalizations.workDay,
                  dateOfBirth: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                  onChangeDateOfBirth: (value) => _setWorkDate(value),
                ),
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

  _setReasonForExplanation(RequisitionTypeExplanationEnum? value) {
    setState(() {
      reasonForExplanation = value;
    });
  }

  _setFollower(List<User> value) {
    setState(() {
      followers = value;
    });
  }

  _setTotalMinute(String value) {
    setState(() {
      totalMinute = value as int;
    });
  }

  _setReason(String value) {
    setState(() {
      reason = value;
    });
  }

  _setDetailedDescription(String value) {
    setState(() {
      reason = value;
    });
  }

  _setDate(String value) {
    setState(() {
      replaceDate = value;
    });
  }

  _setApplicationCode(String value) {
    setState(() {
      applicationCode = value;
    });
  }

  _setFile(List<File> value) {
    setState(() {
      files = value;
    });
  }

  _save() {}

  _cancel() {}

  _setWorkDate(String value) {}
}
