import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class CheckLoadDialog extends StatefulWidget {
  final bool checkLoad, checkSuccess, checkUnSuccess;
  final VoidCallback checkSuccessChange, checkUnSuccessChange;
  final String? fail;

  const CheckLoadDialog(
      {super.key,
      this.checkLoad = false,
      this.checkSuccess = false,
      this.checkUnSuccess = false,
      required this.checkSuccessChange,
      required this.checkUnSuccessChange,
      this.fail});

  @override
  State<CheckLoadDialog> createState() => _CheckLoadDialogState();
}

class _CheckLoadDialogState extends State<CheckLoadDialog> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Stack(
      children: [
        if (widget.checkLoad)
          const Center(
            child: SizedBox(
              height: SpacingUnit.x20,
              width: SpacingUnit.x20,
              child: ProgressIndicatorDialog()
            ),
          ),
        if (widget.checkSuccess)
          Center(
            child: ContainerBorder(
              backgroundColors: colors.background,
              margin: SpacingUnit.x8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    appLocalizations.success,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: SpacingUnit.x8, color: colors.success),
                  ),
                  GestureDetector(
                    onTap: widget.checkSuccessChange,
                    child: ContainerBorder(
                      margin: SpacingUnit.x1,
                      padding: SpacingUnit.x1,
                      height: SpacingUnit.x10,
                      width: SpacingUnit.x20,
                      child: Text(
                        appLocalizations.ok,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        if (widget.checkUnSuccess)
          Center(
            child: BlocBuilder<RequisitionBloc, RequisitionState>(
              builder: (context, state) {
                return ContainerBorder(
                  backgroundColors: colors.background,
                  margin: SpacingUnit.x8,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.fail ?? appLocalizations.unsuccessful,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: SpacingUnit.x8, color: colors.error),
                      ),
                      GestureDetector(
                        onTap: widget.checkUnSuccessChange,
                        child: ContainerBorder(
                          margin: SpacingUnit.x1,
                          padding: SpacingUnit.x1,
                          height: SpacingUnit.x10,
                          width: SpacingUnit.x20,
                          child: Text(
                            appLocalizations.ok,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
