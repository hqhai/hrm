import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_request.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/next_screen_request_information.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/presentations/widgets/custom/app_loading_indicator.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/content_item_approve_requisition_list.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemRequisitionApproveList extends StatefulWidget {
  final String id;
  final EnumStepRequestStatusEnum status;
  final String? departmentId;
  final DateTime? startTime;
  final DateTime? endTime;
  final List<RequisitionTypeEnum>? type;
  final String? userId;

  const ItemRequisitionApproveList({
    super.key,
    this.id = '',
    this.status = EnumStepRequestStatusEnum.newStatus,
    required this.departmentId,
    required this.startTime,
    required this.endTime,
    this.type,
    this.userId,
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
      final request = state.requisitions[widget.id] ?? const Request(id: '');
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
                    child: const AppLoadingIndicator(
                    ),
                  ),
                ),
                Opacity(
                  opacity: checkOpacity ? 0.5 : 1,
                  child: Row(
                    children: [
                      if (widget.status == EnumStepRequestStatusEnum.newStatus)
                        Checkbox(
                          value: checkBox(ids: state.ids, request: request),
                          onChanged: (value) {
                            _addEventId(request: request);
                          },
                        ),
                      Expanded(
                        child: ContentItemRequestApproveList(
                          id: widget.id,
                          status: widget.status,
                          startDate: widget.startTime,
                          endDate: widget.endTime,
                          type: widget.type,
                          userId: widget.userId,
                        ),
                      ),
                    ],
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

  String? _getIdRequest({required Request request}) {
    String idUser = dI<UserBloc>().state.user.id;
    if (request.stepRequests.isNotEmpty) {
      final stepRequests = request.stepRequests;
      final indexNewStepRequest = stepRequests.indexWhere(
          (element) => element.status == EnumStepRequestStatusEnum.newStatus);
      if (indexNewStepRequest != -1) {
        final stepRequest = stepRequests[indexNewStepRequest];
        final stepRequestApproves = stepRequest.stepRequestApprovers;
        final int indexNewRequest = stepRequestApproves
            .indexWhere((element) => element.approverId == idUser);
        if (indexNewRequest != -1) {
          String idStepRequestApprove = stepRequestApproves[indexNewRequest].id;
          return idStepRequestApprove;
        }
      }
    }
    return '';
  }

  _addEventId({required Request request}) {
    final id = _getIdRequest(request: request);
    dI<RequisitionApproveBloc>().add(AddIdRequisitionEvent(id: id ?? ''));
  }

  bool checkBox({required List<String> ids, required Request request}) {
    final id = _getIdRequest(request: request);
    return ids.contains(id);
  }
}
