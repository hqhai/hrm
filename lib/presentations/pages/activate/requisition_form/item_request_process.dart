import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/button_item_list_requisition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemRequestProcess extends StatelessWidget {
  final VoidCallback callBackApprove;
  final VoidCallback callBackEdit;
  final VoidCallback callBackReject;
  final bool hiddenApproveButton;

  const ItemRequestProcess({
    super.key,
    required this.callBackApprove,
    required this.callBackEdit,
    required this.callBackReject,
    required this.hiddenApproveButton,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            hiddenApproveButton
                ? const SizedBox()
                : Expanded(
                    child: ButtonItemListRequisition(
                      colorText: colors.success,
                      background: colors.success.withOpacity(0.2),
                      title: appLocalizations.approver,
                      callback: () => callBackApprove.call(),
                    ),
                  ),
            Expanded(
              child: ButtonItemListRequisition(
                colorText: colors.tertiary,
                background: colors.tertiary.withOpacity(0.2),
                title: appLocalizations.modification,
                callback: () => callBackEdit.call(),
              ),
            ),
            Expanded(
              child: ButtonItemListRequisition(
                colorText: colors.error,
                background: colors.error.withOpacity(0.2),
                title: appLocalizations.refuse,
                callback: () => callBackReject.call(),
              ),
            ),
          ],
        );
      },
    );
  }
}
