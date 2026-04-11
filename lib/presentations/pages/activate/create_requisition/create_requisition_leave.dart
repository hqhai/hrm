import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/create_and_edit_request.dart';
import 'package:base_app/common/utils/error_utils.dart';
import 'package:base_app/common/utils/limit_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_model_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/presentations/widgets/custom/app_loading_indicator.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/create_leave_form/create_leave_form_cubit.dart';
import 'package:base_app/presentations/bloc/requisition/create_leave_form/create_leave_form_state.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_event.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/pages/activate/leave/item_work_shift.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/business/number_work.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_list_step_flow.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_load_flie.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create.work.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_create_take_leave.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/on_leave/item_year_leave.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/custom/period_time_picker.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequestLeavePageRoute = GoRoute(
    path: Pages.createRequestLeavePage,
    name: Pages.createRequestLeavePage,
    builder: (context, GoRouterState state) {
      Map data = state.extra == null ? {} : state.extra as Map;
      return CreateRequisitionLeavePage(
        flowId: data['flowId'],
        requestId: data['requestId'],
        type: data['type'],
        date: data["date"] == null
            ? DateTime.now()
            : DateTime.parse(data['date']),
      );
    });

class CreateRequisitionLeavePage extends StatefulWidget {
  const CreateRequisitionLeavePage({
    super.key,
    this.flowId = '',
    this.requestId = '',
    this.type = RequisitionTypeEnum.leaveHalfDayToOneDay,
    this.date,
  });

  final RequisitionTypeEnum type;
  final String flowId;
  final String requestId;
  final DateTime? date;

  @override
  State<CreateRequisitionLeavePage> createState() =>
      _CreateRequisitionLeavePageState();
}

class _CreateRequisitionLeavePageState
    extends State<CreateRequisitionLeavePage> {
  final TextEditingController _descriptionController = TextEditingController();

  CreateLeaveFormCubit get _cubit => dI<CreateLeaveFormCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.requestId.isNotEmpty) {
        final requisition = dI<RequisitionBloc>().state.requisition;
        _cubit.loadFromConfig(
          config: requisition.config,
          followerIds: requisition.followerIds,
        );
        _descriptionController.text = requisition.config.description;
      } else {
        _cubit.reset();
      }
    });
    _descriptionController.addListener(_checkWords);
  }

  @override
  void dispose() {
    _descriptionController.removeListener(_checkWords);
    _descriptionController.dispose();
    super.dispose();
  }

  void _checkWords() {
    final text = _descriptionController.text;
    final words = text.trim().split(RegExp(r'\s+'));
    if (words.length > Limit.limitText) {
      _cubit.descriptionErrorChanged('Vượt quá giới hạn 255 từ');
      final limited = words.sublist(0, Limit.limitText).join(' ');
      _descriptionController.value = TextEditingValue(
        text: limited,
        selection:
            TextSelection.fromPosition(TextPosition(offset: limited.length)),
      );
    } else {
      _cubit.descriptionErrorChanged('');
    }
    _cubit.descriptionChanged(_descriptionController.text);
  }

  void _onRequisitionStatusChanged(BuildContext context, RequisitionState s) {
    final message = s.errorCode.isNotEmpty
        ? ErrorUtils.getErrorMessage(s.errorCode, context: context)
        : '';
    _cubit.errorDialogChanged(message);
  }

  Future<void> _onEndTimeChanged(DateTime value) async {
    _cubit.endTimeChanged(value);
    final start = _cubit.state.startTime;
    if (start == null) return;

    final completer = Completer<bool>();
    dI<LeaveShiftBloc>().add(
      GetWorkShiftsEvent(
        endDate: value,
        startDate: start,
        completer: completer,
      ),
    );
    final loaded = await completer.future;
    if (loaded) _cubit.shiftsLoaded();
  }

  PostRequestRequest _buildRequest() {
    final s = _cubit.state;
    final config = ConfigModelRequest(
      takeLeaveReason: s.reason,
      description: _descriptionController.text,
      subtitudePersons: s.substitutes,
      endDate: s.endTime,
      startDate: s.startTime,
      workShiftSettings: s.workShifts,
      reasonLeave: s.reason,
      takeLeaveType: s.takeLeaveType,
      numberValue: s.numberValue,
    );
    return widget.requestId.isEmpty
        ? PostRequestRequest(
            followerIds: s.followers,
            flowId: widget.flowId,
            config: config,
          )
        : PostRequestRequest(
            id: widget.requestId,
            followerIds: s.followers,
            flowId: widget.flowId,
            config: config,
          );
  }

  void _onSave(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isShiftValid = _cubit.validate(
      shiftRequiredMessage: l10n.notSelectedAShift,
    );
    final isReasonOk = _cubit.isReasonValid;
    final state = _cubit.state;
    final canCreate = !state.isSaving &&
        widget.requestId.isEmpty &&
        isShiftValid &&
        isReasonOk;
    final canEdit = !state.isSaving &&
        widget.requestId.isNotEmpty &&
        isShiftValid &&
        isReasonOk;

    saveRequest(
      files: state.files,
      checkCreate: canCreate,
      postRequestRequest: _buildRequest(),
      checkEdit: canEdit,
      checkLoadTrue: () {
        // mirrors the legacy `setCheckLoad` callback
        _cubit.markSaving();
      },
    );
  }

  void _onCancel(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);

    return BlocListener<RequisitionBloc, RequisitionState>(
      listenWhen: (a, b) => a.errorCode != b.errorCode,
      listener: _onRequisitionStatusChanged,
      child: BlocBuilder<UserByIdBloc, UserByIdState>(
        builder: (context, _) {
          return BlocBuilder<CreateLeaveFormCubit, CreateLeaveFormState>(
            builder: (context, formState) {
              return Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(color: colors.text),
                  title: Text(
                    widget.type.configTypeCreateName,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x5,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: ContainerScreenMain(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemTakeLeave(
                          type: formState.takeLeaveType,
                          onChangeType: _cubit.leaveTypeChanged,
                        ),
                        const SizedBox(height: SpacingUnit.x4),
                        ItemYearLeave(
                          typeReason: formState.reason,
                          typeSocialInsurance: formState.socialInsuranceLeave,
                          onChange: _cubit.reasonChanged,
                          type: formState.takeLeaveType,
                          onChangeSocialInsurance:
                              _cubit.socialInsuranceChanged,
                        ),
                        if (formState.takeLeaveType !=
                                EnumTakeLeaveType.unpaidLeave &&
                            _cubit.isReasonValid)
                          ItemTakeLeaveWork(
                            reasonLeave: formState.reason,
                            type: formState.takeLeaveType,
                          ),
                        const SizedBox(height: SpacingUnit.x4),
                        TitleRequired(
                          title: l10n.intervalOnLeave,
                          requiredValidate: true,
                        ),
                        const SizedBox(height: SpacingUnit.x2),
                        PeriodTimePicker(
                          oldEndTime: formState.endTime,
                          oldStarTime: formState.startTime,
                          title: l10n.intervalOnLeave,
                          setStarTime: (value) =>
                              _cubit.startTimeChanged(value ?? DateTime.now()),
                          setEndTime: (value) =>
                              _onEndTimeChanged(value ?? DateTime.now()),
                          fontWeightTitle: FontWeight.w600,
                        ),
                        if (!formState.isFirstShift) ...[
                          const SizedBox(height: SpacingUnit.x4),
                          !formState.isShiftLoaded
                              ? const Center(
                                  child: AppLoadingIndicator(),
                                )
                              : ItemWorkShift(
                                  workShiftSettingsOld: formState.workShifts,
                                  workShiftSettings: _cubit.workShiftsChanged,
                                ),
                        ],
                        BlocBuilder<LeaveShiftBloc, LeaveShiftState>(
                          builder: (context, shiftState) {
                            final shouldShow =
                                (formState.errorShift.isNotEmpty &&
                                        shiftState.keys.isNotEmpty) ||
                                    formState.isFirstShift;
                            if (!shouldShow) return const SizedBox();
                            return Text(
                              formState.errorShift,
                              style: TextStyle(
                                color: colors.error,
                                fontSize: SpacingUnit.x3,
                              ),
                            );
                          },
                        ),
                        if (!formState.isFirstShift && formState.isShiftLoaded)
                          NumberWorkWidget(
                            title: l10n.totalLeaveWork,
                            value: formState.numberValue.toString(),
                          ),
                        ItemLoadFile(
                          files: formState.files,
                          onChangeFiles: _cubit.filesChanged,
                        ),
                        ItemCreateInputArea(
                          textInputFormatter: [
                            LengthLimitingTextInputFormatter(500),
                          ],
                          error: formState.errorDescription,
                          textController: _descriptionController,
                          title: l10n.detailedDescription,
                          onChange: _cubit.descriptionChanged,
                        ),
                        const ItemListStepFlow(),
                        ItemButton(
                          id: widget.requestId,
                          callbackSave: () => _onSave(context),
                          callbackCancel: () => _onCancel(context),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
