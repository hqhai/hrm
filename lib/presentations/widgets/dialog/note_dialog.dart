import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:flutter/material.dart';

noteDialog(BuildContext context, EnumStepRequestStatusEnum status, String id) async {
  final TextEditingController noteController = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      final appLocalizations = AppLocalizations.of(context)!;
      return AlertDialog(
        content: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(appLocalizations.note),
              const SizedBox(
                height: SpacingUnit.x4_5,
              ),
              AppInputArea(
                minLines: 5,
                maxLines: 5,
                placeHolder: appLocalizations.note,
                controller: noteController,
              ),
              const SizedBox(
                height: SpacingUnit.x4_5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _setApprove(id, noteController.text, status, context),
                    child: Text(appLocalizations.ok),
                  ),
                  ElevatedButton(
                    child: Text(appLocalizations.cancel),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

_setApprove(String id, String text, EnumStepRequestStatusEnum status, BuildContext context) {
  dI<RequisitionApproveBloc>().add(
    ApproveRequestEvent(
      id: id,
      note: text,
      status: status,
    ),
  );
  Navigator.of(context).pop();
}
