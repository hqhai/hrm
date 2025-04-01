import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/requisition_info_item/item/item_info_over_time.dart';
import 'package:base_app/presentations/widgets/activate/requisition_info_item/requisition_overtime_header.dart';
import 'package:flutter/material.dart';
import 'package:widgets/app_button.dart';

import '../../../../domain/entities/requisition/requisition_over_time.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  required VoidCallback onCancel,
  List<RequisitionOverTime>? data,
}) async {
  final theme = Theme.of(context);
  final appLocalizations = AppLocalizations.of(context)!;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: onCancel,
                    child: const Icon(Icons.close),
                  ),
                  Text(
                    appLocalizations.i18nOTInformationList,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const RequisitionOvertimeHeader(),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => ItemInfoOverTime(
                  data: data?[index],
                ),
                itemCount: data?.length,
              ),
              AppButton(
                title: appLocalizations.i18nClose,
                onSubmit: onCancel,
                color: const Color(0xFFE5E7E8),
              )
            ],
          ),
        ),
      );
    },
  );
}
