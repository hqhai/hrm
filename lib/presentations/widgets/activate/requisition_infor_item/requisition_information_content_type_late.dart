import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationContentTypeLate extends StatefulWidget {
  const RequisitionInformationContentTypeLate({
    super.key,
  });

  @override
  State<RequisitionInformationContentTypeLate> createState() =>
      _RequisitionInformationContentTypeLateState();
}

class _RequisitionInformationContentTypeLateState
    extends State<RequisitionInformationContentTypeLate> {
  List<bool> listCheck = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(state),
      listenWhen: (previous, current) => previous.requisition != current.requisition,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appLocalizations.time,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x3,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  formatYMD(state.requisition.config.startDate.toString()),
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  checkSubmit(int index) {
    setState(() {
      listCheck[index] = !listCheck[index];
    });
  }

  onClick(int index) {
    setState(() {
      listCheck[index] = !listCheck[index];
    });
  }

  _listener(RequisitionState state) {
    setState(() {
      final int count = state.requisition.config.overTimes!.length;
      listCheck = List.filled(count, true);
    });
  }
}
