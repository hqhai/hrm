import 'package:base_app/common/enum/enum_request.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/next_screen_request_information.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/content_item_approve_requisition_list.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:themes/themes.dart';

class ItemRequisitionApproveList extends StatefulWidget {
  final String id;
  final EnumStepRequestStatusEnum status;

  const ItemRequisitionApproveList({
    super.key,
    this.id = '',
    this.status = EnumStepRequestStatusEnum.newStatus,
  });

  @override
  State<ItemRequisitionApproveList> createState() =>
      _ItemRequisitionApproveListState();
}

class _ItemRequisitionApproveListState
    extends State<ItemRequisitionApproveList> {
  String? note;
  bool checkOpacity = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionApproveBloc, RequisitionApproveState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
        child: ContainerBorder(
          backgroundColors: colors.background,
          borderColors: colors.background,
          child: InkWell(
            onTap: () => nextScreenRequest(
              context: context,
              id: widget.id,
              checkOpacity: checkOpacity,
              setState: () => setOpacity(),
              checkUser: RequestSeeByWho.manager,
            ),
            child: Stack(
              children: [
                Opacity(
                  opacity: checkOpacity ? 1 : 0,
                  child: Center(
                    child: Lottie.asset(
                      Assets.images.icon.loading,
                      width: SpacingUnit.x20,
                      height: SpacingUnit.x20,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Opacity(
                  opacity: checkOpacity ? 0.5 : 1,
                  child: ContentItemRequestApproveList(
                    id: widget.id,
                    status: widget.status,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  setOpacity() {
    setState(() {
      checkOpacity = !checkOpacity;
    });
  }

  bool checkNote(EnumStepRequestStatusEnum status) {
    if ((status == EnumStepRequestStatusEnum.reject ||
            status == EnumStepRequestStatusEnum.edit) &&
        note == null) {
      return false;
    }
    return true;
  }
}
