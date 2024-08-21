import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/dialog/image_dialog/image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final width = MediaQuery.of(context).size.width;
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
              if (state.requisition.config.attachments.isNotEmpty)
                SizedBox(
                  height: width * state.requisition.config.attachments.length * 0.3 * 0.5,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: SpacingUnit.x10,
                    ),
                    itemCount: state.requisition.config.attachments.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () =>
                          _onClickFLie(context, index, state.requisition.config.attachments),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SpacingUnit.x1),
                          color: colors.background,
                          border: Border.all(color: colors.text, width: 1),
                        ),
                        child: _checkTypeFile(index, state.requisition.config.attachments)
                            ? Center(
                                child: Text(
                                  appLocalizations.pdf,
                                  style: TextStyle(
                                    color: colors.text,
                                    fontSize: SpacingUnit.x7,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              )
                            : Image.network(
                                state.requisition.config.attachments[index],
                                fit: BoxFit.fill,
                              ),
                      ),
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

  _onClickFLie(BuildContext context, int index, List<String> list) {
    if (_checkTypeFile(index, list)) {
      dI<AppNavigation>().pushName(context, page: Pages.pDFPage, extra: {
        'url': list[index],
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: ImageDialog(
              url: list[index],
            ),
          );
        },
      );
    }
  }

  bool _checkTypeFile(int index, List<String> list) {
    final int length = list[index].length;
    final String type = list[index].substring(length - 3, length);
    if (type == 'pdf' || type == 'PDF') {
      return true;
    } else {
      return false;
    }
  }
}
