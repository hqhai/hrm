import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemActivateWidget extends StatefulWidget {
  const ItemActivateWidget({
    super.key,
    this.title = '',
    required this.callback,
    this.color = Colors.white,
    this.padding = SpacingUnit.x2,
    this.paddingVertical = SpacingUnit.x2,
    this.index = 0,
  });

  final String title;
  final VoidCallback callback;
  final Color color;
  final double padding;
  final double paddingVertical;
  final int index;

  @override
  State<ItemActivateWidget> createState() => _ItemActivateWidgetState();
}

class _ItemActivateWidgetState extends State<ItemActivateWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.callback,
      child: ContainerBorder(
        backgroundColors: widget.color,
        borderColors: widget.color,
        width: width,
        paddingVertical: widget.paddingVertical,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.all(widget.padding),
                child: Row(
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x4,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: SpacingUnit.x2,
                    ),
                    widget.index == 2
                        ? Container(
                            padding: const EdgeInsets.all(SpacingUnit.x2),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(SpacingUnit.x100),
                              color: colors.primary,
                            ),
                            child: BlocBuilder<RequisitionApproveBloc,
                                RequisitionApproveState>(
                              builder: (context, state) {
                                return Text(
                                  (state.statusRequestCount[
                                              EnumStepRequestStatusEnum
                                                  .newStatus] ??
                                          0)
                                      .toString(),
                                  style: const TextStyle(color: Colors.white),
                                );
                              },
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_outlined,
              color: colors.text,
              size: SpacingUnit.x6,
            ),
          ],
        ),
      ),
    );
  }
}
