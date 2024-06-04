import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/dialog/pdf_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class RequisitionInformationAttach extends StatefulWidget {
  const RequisitionInformationAttach({super.key});

  @override
  State<RequisitionInformationAttach> createState() => _RequisitionInformationAttachState();
}

class _RequisitionInformationAttachState extends State<RequisitionInformationAttach> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.attach,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x3,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: SpacingUnit.x4,
              ),
              GestureDetector(
                onTap: () => _showDialog(context, state),
                child: Container(
                  height: SpacingUnit.x15,
                  width: SpacingUnit.x15,
                  padding: const EdgeInsets.all(SpacingUnit.x3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SpacingUnit.x1),
                    color: CustomsColor.colorBackground,
                    border: Border.all(color: colors.text, width: 1),
                  ),
                  child: SvgPicture.asset(
                    Assets.images.icon.activateIcon.fileAttach,
                    colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                  ),
                ),
              ),
              const SizedBox(
                height: SpacingUnit.x2,
              ),
              SizedBox(
                width: SpacingUnit.x20,
                child: Text(
                  appLocalizations.workApplicationForm,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x3,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _showDialog(BuildContext context, RequisitionState state) {
    bool check = state.requisition.filePaths?.isNotEmpty ?? false;
    if (check) {
      pDFShowDialog(context, state.requisition.filePaths ?? []);
    }
  }
}
