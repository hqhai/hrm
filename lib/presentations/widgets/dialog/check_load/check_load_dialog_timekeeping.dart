import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:themes/themes.dart';

class CheckLoadTimekeepingDialog extends StatefulWidget {
  final bool checkLoad, checkSuccess, checkUnSuccess;
  final VoidCallback checkSuccessChange, checkUnSuccessChange;
  final String? fail;

  const CheckLoadTimekeepingDialog(
      {super.key,
      this.checkLoad = false,
      this.checkSuccess = false,
      this.checkUnSuccess = false,
      required this.checkSuccessChange,
      required this.checkUnSuccessChange,
      this.fail});

  @override
  State<CheckLoadTimekeepingDialog> createState() => _CheckLoadTimekeepingDialogState();
}

class _CheckLoadTimekeepingDialogState extends State<CheckLoadTimekeepingDialog> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Stack(
      children: [
        if (widget.checkLoad)
          Center(
            child: ContainerBorder(
              height: SpacingUnit.x50,
              width: SpacingUnit.x50,
              child: Lottie.asset(Assets.images.icon.loading,
                  width: SpacingUnit.x50, height: SpacingUnit.x50, fit: BoxFit.fill),
            ),
          ),
        if (widget.checkSuccess)
          Center(
            child: ContainerBorder(
              margin: SpacingUnit.x8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.images.timeKeeping.notoWorldMap.path,
                    fit: BoxFit.fill,
                    height: SpacingUnit.x50,
                    width: SpacingUnit.x50,
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
                  ),
                ],
              ),
            ),
          ),
        if (widget.checkUnSuccess)
          Center(
            child: BlocBuilder<RequisitionBloc, RequisitionState>(
              builder: (context, state) {
                return ContainerBorder(
                  margin: SpacingUnit.x8,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Assets.images.timeKeeping.unWorldMap.path,
                        fit: BoxFit.fill,
                        height: SpacingUnit.x50,
                        width: SpacingUnit.x50,
                      ),
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
