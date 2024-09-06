import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/flow.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ListCheckboxFlowRequestFilter extends StatefulWidget {
  const ListCheckboxFlowRequestFilter({super.key, required this.onChange, required this.listFlows});

  final ValueChanged<List<FlowRequest>> onChange;
  final List<FlowRequest> listFlows;

  @override
  State<ListCheckboxFlowRequestFilter> createState() =>
      _ListCheckboxFlowRequestFilterState();
}

class _ListCheckboxFlowRequestFilterState
    extends State<ListCheckboxFlowRequestFilter> {
  List<FlowRequest> listFlows = [];

  @override
  void initState() {
    listFlows = widget.listFlows;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<FlowBloc, FlowState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              appLocalizations.type,
              style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x3_5,
                  fontWeight: FontWeight.w400),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.flows
                        .mapIndexed(
                          (index, element) => Column(
                            children: [
                              CheckboxListTile(
                                value: listFlows.any((e) => e.flowType == element.flowType),
                                onChanged: (value) => setValue(
                                    index: index, value: value, flow: element),
                                subtitle: Text(
                                  element.flowType.configTypeNameFilter,
                                  style: TextStyle(
                                      color: colors.text,
                                      fontSize: SpacingUnit.x3_5,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Divider(
                                height: SpacingUnit.x0_25,
                                color: colors.outline.withOpacity(0.2),
                              )
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  setValue({required int index, bool? value, required FlowRequest flow}) {
    setState(() {
      if (value == true) {
        listFlows.add(flow);
        widget.onChange.call(listFlows);
      } else {
        listFlows.remove(flow);
        widget.onChange.call(listFlows);
      }
    });
  }
}
