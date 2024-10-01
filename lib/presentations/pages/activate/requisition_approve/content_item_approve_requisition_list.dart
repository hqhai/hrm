import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/pages/activate/requisition_form/item_request_cancel.dart';
import 'package:base_app/presentations/pages/activate/requisition_form/item_request_process.dart';
import 'package:base_app/presentations/widgets/custom/app_icon_status.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/note/note_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ContentItemRequestApproveList extends StatefulWidget {
  const ContentItemRequestApproveList({super.key, required this.id, required this.status});

  final EnumStepRequestStatusEnum status;
  final String id;

  @override
  State<ContentItemRequestApproveList> createState() => _ContentItemRequestApproveListState();
}

class _ContentItemRequestApproveListState extends State<ContentItemRequestApproveList> {
  String note = '';
  String errorCodeDialog = '';

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocConsumer<RequisitionApproveBloc, RequisitionApproveState>(
      listener: (context, state) => _listener(state.errorCode, context),
      builder: (context, state) {
        final request = state.requisitions[widget.id] ?? const Request(id: '');
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: SpacingUnit.x2_5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    request.flowType.configTypeName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: colors.text, fontSize: SpacingUnit.x4, fontWeight: FontWeight.w700),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: colors.text,
                    size: SpacingUnit.x6,
                  ),
                ],
              ),
            ),
            TitleValueLeave(
              size: SpacingUnit.x3_5,
              padding: SpacingUnit.x1_5,
              title: appLocalizations.creator,
              value: request.createdFullName,
            ),
            TitleValueLeave(
              size: SpacingUnit.x3_5,
              padding: SpacingUnit.x1_5,
              title: appLocalizations.createTime,
              value: formatYMDHMS(
                (dateTimeLocal(request.createdDate) ?? "").toString(),
              ),
            ),
            TitleValueLeave(
              size: SpacingUnit.x3_5,
              padding: SpacingUnit.x1_5,
              title: appLocalizations.code,
              value: request.code,
              color: colors.success,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2_5),
              child: AppIconStatus(
                color: statusRequest(context: context)['color'],
                icon: statusRequest(context: context)['icon'],
                status: widget.status.configStepRequestStatusName,
              ),
            ),
            if (statusApprove(request) == EnumStepRequestStatusEnum.newStatus)
              ItemRequestProcess(
                callBackApprover: () => _isApprover(
                  request,
                  context,
                  EnumStepRequestStatusEnum.approve,
                ),
                callBackEdit: () => _isApprover(
                  request,
                  context,
                  EnumStepRequestStatusEnum.edit,
                ),
                callBackReject: () => _isApprover(
                  request,
                  context,
                  EnumStepRequestStatusEnum.reject,
                ),
              ),
            //if (checkFirstStepApprove(request))
            if (request.isFirstStep && request.status == StatusRequestEnum.approve)
              ItemRequestCancel(callCancel: () => _showDialogCancelRequest(context)),
          ],
        );
      },
    );
  }

 /* bool checkFirstStepApprove(Request request) {
    if (request.status == StatusRequestEnum.approve) {
      final id = dI<UserBloc>().state.user.id;
      final stepRequests = request.stepRequests
          .where((element) => element.status == EnumStepRequestStatusEnum.approve)
          .toList();
      if (stepRequests != []) {
        stepRequests.sort((a, b) {
          int dateComparison = a.createdDate?.microsecondsSinceEpoch ??
              0.compareTo(b.createdDate?.microsecondsSinceEpoch ?? 0);
          return dateComparison;
        });
        final stepRequestApprovers = stepRequests.first.stepRequestApprovers;
        if (stepRequestApprovers != []) {
          final checkId = stepRequestApprovers!.first.approverId == id;
          return checkId;
        }
        return false;
      }
      return false;
    }
    return false;
  }*/

  _isApprover(request, BuildContext context, EnumStepRequestStatusEnum status) {
    String idUser = dI<UserBloc>().state.user.id;
    if (request.stepRequests?.isNotEmpty ?? false) {
      final stepRequests = request.stepRequests ?? [];
      final indexNewStepRequest = stepRequests
          .indexWhere((element) => element.status == EnumStepRequestStatusEnum.newStatus);
      if (indexNewStepRequest != -1) {
        final stepRequest = stepRequests[indexNewStepRequest];
        final stepRequestApproves = stepRequest.stepRequestApprovers ?? [];
        final int indexNewRequest =
            stepRequestApproves.indexWhere((element) => element.approverId == idUser);
        if (indexNewRequest != -1) {
          String idStepRequestApprove = stepRequestApproves[indexNewRequest].id;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: NoteDialog(
                    noteChange: (value) => _setNote(value),
                    callback: () => _setApprove(idStepRequestApprove, status, context),
                    status: status),
              );
            },
          );
        }
      }
    }
  }

  _setApprove(String id, EnumStepRequestStatusEnum status, BuildContext context) async {
    setCheckLoad();
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool>();
    dI<RequisitionApproveBloc>().add(
      ApproveRequestEvent(
        id: id,
        note: note,
        status: status,
        requestId: widget.id,
        completer: completer,
      ),
    );
    final statusCompleter = await completer.future;
    if (statusCompleter == true) {
      if (!currentContext.mounted) return;
      final title = _getTextSucceed(currentContext, status);
      approverSuccess(context: currentContext, title: title);
    }
    if (statusCompleter == false) {
      if (!currentContext.mounted) return;
      approverUnsuccessful(
          errorDialog: errorCodeDialog,
          context: currentContext,
          title: _getTextFailed(context, status));
    }
  }

  String _getTextSucceed(BuildContext context, EnumStepRequestStatusEnum status) {
    final appLocalizations = AppLocalizations.of(context)!;
    switch (status) {
      case EnumStepRequestStatusEnum.approve:
        return appLocalizations.approveSucceed;
      case EnumStepRequestStatusEnum.cancel:
        return appLocalizations.cancelSucceed;
      case EnumStepRequestStatusEnum.edit:
        return appLocalizations.requestSucceed;
      case EnumStepRequestStatusEnum.reject:
        return appLocalizations.rejectSucceed;
      default:
        return 'Thành Công';
    }
  }

  String _getTextFailed(BuildContext context, EnumStepRequestStatusEnum status) {
    final appLocalizations = AppLocalizations.of(context)!;
    switch (status) {
      case EnumStepRequestStatusEnum.approve:
        return appLocalizations.approveFailed;
      case EnumStepRequestStatusEnum.cancel:
        return appLocalizations.cancelFailed;
      case EnumStepRequestStatusEnum.edit:
        return appLocalizations.requestFailed;
      case EnumStepRequestStatusEnum.reject:
        return appLocalizations.rejectFailed;
      default:
        return 'Thành Công';
    }
  }

  approverSuccess({required BuildContext context, String? title}) {
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: CreateRequestSuccess(
            title: title ?? appLocalizations.approvedSuccess,
          ),
        );
      },
    ).then((value) {
      popLoading(context);
    });
  }

  popLoading(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  approverUnsuccessful(
      {required String errorDialog, required BuildContext context, required String title}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: CreateRequestUnsuccessful(
            title: errorDialog.isNotEmpty ? errorDialog : title,
          ),
        );
      },
    ).then((value) {
      dI<AppNavigation>().pop(context);
    });
  }

  _setNote(String value) {
    setState(() {
      note = value;
    });
  }

  EnumStepRequestStatusEnum? statusApprove(Request request) {
    String idUser = dI<UserBloc>().state.user.id;
    if (request.stepRequests.isNotEmpty) {
      final stepRequests = request.stepRequests;
      final indexNewStepRequest = stepRequests
          .indexWhere((element) => element.status == EnumStepRequestStatusEnum.newStatus);
      if (indexNewStepRequest != -1) {
        final stepRequest = stepRequests[indexNewStepRequest];
        final stepRequestApproves = stepRequest.stepRequestApprovers ?? [];
        final int indexNewRequest =
            stepRequestApproves.indexWhere((element) => element.approverId == idUser);
        if (indexNewRequest != -1) {
          EnumStepRequestStatusEnum? statusStepRequestApprove =
              stepRequestApproves[indexNewRequest].status;
          return statusStepRequestApprove;
        }
      }
    }
    return null;
  }

  Map<String, dynamic> statusRequest({
    required BuildContext context,
  }) {
    final colors = AppTheme.getColors(context);
    switch (widget.status) {
      case EnumStepRequestStatusEnum.newStatus:
        return {
          'color': colors.goldenPurple,
          'icon': Assets.images.icon.work.loading,
        };
      case EnumStepRequestStatusEnum.reject:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.loading,
        };
      case EnumStepRequestStatusEnum.edit:
        return {
          'color': colors.tertiary,
          'icon': Assets.images.icon.work.edit,
        };
      case EnumStepRequestStatusEnum.approve:
        return {
          'color': colors.success,
          'icon': Assets.images.icon.work.success,
        };
      case EnumStepRequestStatusEnum.cancel:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.reject,
        };
      case EnumStepRequestStatusEnum.overdueApprove:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.outDate,
        };
      default:
        return {};
    }
  }

  _listener(String errorCode, BuildContext context) {
    setState(() {
      errorCodeDialog = errorCode.isNotEmpty ? setErrorValue(errorCode, context) ?? errorCode : "";
    });
  }

  _showDialogCancelRequest(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: NoteCancelRequestDialog(
            noteChange: (value) => _setNote(value),
            callback: () => _cancelRequest(),
          ),
        );
      },
    );
  }

  _cancelRequest() async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    setCheckLoad();
    final Completer completer = Completer<bool>();
    dI<RequisitionApproveBloc>().add(
      CancelRequestEvent(
        requestId: widget.id,
        note: note,
        completer: completer,
      ),
    );
    final statusCompleter = await completer.future;
    if (statusCompleter == true) {
      dI<RequisitionBloc>().add(GetRequisitionByIdEvent(id: widget.id));
      if (!currentContext.mounted) return;
      approverSuccess(context: currentContext, title: appLocalizations.cancelSucceed);
    }
    if (statusCompleter == false) {
      if (!currentContext.mounted) return;
      approverUnsuccessful(
          context: currentContext,
          errorDialog: errorCodeDialog,
          title: appLocalizations.cancelFailed);
    }
  }
}
