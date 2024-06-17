import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/flow_enum.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';


class BottomSheetFlowWidget extends StatefulWidget {
  const BottomSheetFlowWidget({
    super.key,
    required this.onChange,
  });

  final ValueChanged<FlowRequest> onChange;

  @override
  State<BottomSheetFlowWidget> createState() => _BottomSheetFlowWidgetState();
}

class _BottomSheetFlowWidgetState extends State<BottomSheetFlowWidget> {
  late ScrollController controller;
  int pageIndex = 1, totalItems = 0, lengthList = 0;
  FlowStatusEnum status = FlowStatusEnum.getFlowsInit;

  @override
  void initState() {
    dI<FlowBloc>().add(const GetFlowsEvent());
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.of(context).size.height;
    return BlocConsumer<FlowBloc, FlowState>(
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Container(
          height: height * 0.6,
          color: colors.surface,
          child: Center(
            child: SizedBox(
              height: height * 0.4,
              child: ListView.builder(
                controller: controller,
                itemCount: state.flows.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => setOnChange(
                    flow: state.flows[index],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(SpacingUnit.x2),
                    margin: const EdgeInsets.all(SpacingUnit.x2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SpacingUnit.x2),
                      color: CustomsColor.colorBackground,
                      border: Border.all(
                        color: colors.text,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${index + 1}.    ',
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                        Text(
                          state.flows[index].name ?? "",
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  setOnChange({required FlowRequest flow}) {
    widget.onChange.call(flow);
    Navigator.of(context).pop();
  }

  _scrollListener() {
    if (lengthList <= totalItems &&
        status == FlowStatusEnum.getFlowsSuccess &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      dI<FlowBloc>().add(GetFlowsEvent(
        page: pageIndex,
      ));
    }
  }

  _listener(BuildContext context, FlowState state) {
    setState(() {
      status = state.status;
      totalItems = state.totalItems;
      lengthList = state.flows.length;
    });
  }
}
