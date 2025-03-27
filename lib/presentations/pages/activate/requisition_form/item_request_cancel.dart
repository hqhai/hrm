import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/button_item_list_requisition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemRequestCancel extends StatelessWidget {
  const ItemRequestCancel({super.key, required this.callCancel});

  final VoidCallback callCancel;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ButtonItemListRequisition(
                colorText: colors.text.withValues(alpha: 0.7),
                background: colors.text.withValues(alpha: 0.2),
                title: appLocalizations.approver,
                callback: () {},
              ),
            ),
            const SizedBox(width: SpacingUnit.x4),
            Expanded(
              child: ButtonItemListRequisition(
                colorText: colors.text.withValues(alpha: 0.7),
                background: colors.text.withValues(alpha: 0.2),
                title: appLocalizations.modification,
                callback: () {},
              ),
            ),
            const SizedBox(width: SpacingUnit.x4),
            Expanded(
              child: ButtonItemListRequisition(
                colorText: colors.error,
                background: colors.error.withValues(alpha: 0.2),
                title: appLocalizations.cancelRequest,
                callback: () => callCancel.call(),
              ),
            ),
          ],
        );
      },
    );
  }
}
