import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/use_cases/check_in_setting_usecase.dart';
import 'package:base_app/presentations/bloc/checkin_setting/check_in_setting_event.dart';
import 'package:base_app/presentations/bloc/checkin_setting/check_in_setting_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckInSettingBloc extends HydratedBloc<CheckInSettingEvent, CheckInSettingState> {
  final CheckInSettingUseCase checkInSettingUseCase;

  CheckInSettingBloc()
      : checkInSettingUseCase = dI<CheckInSettingUseCase>(),
        super(const CheckInSettingState()) {
    on<CheckInSettingEvent>((event, emit) {});
    on<CreateCheckInSettingEvent>(_createCheckInSettingEvent);
    on<ResetCheckInSettingEvent>(_resetCheckInSettingEvent);
  }

  FutureOr<void> _createCheckInSettingEvent(
      CreateCheckInSettingEvent event, Emitter<CheckInSettingState> emit) async {
    emit(state.copyWith(status: CheckInSettingStatus.createCheckInSettingInit));
    try {
      await checkInSettingUseCase.createCheckInSetting(
          departmentId: event.departmentId,
          afternoonStartTime: event.afternoonStartTime,
          afternoonEndTime: event.afternoonEndTime,
          morningStartTime: event.morningStartTime,
          morningEndTime: event.morningEndTime);
      emit(state.copyWith(status: CheckInSettingStatus.createCheckInSettingSuccess));
    } catch (e) {
      emit(state.copyWith(status: CheckInSettingStatus.createCheckInSettingError));
    }
  }

  @override
  CheckInSettingState? fromJson(Map<String, dynamic> json) {
    return CheckInSettingState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CheckInSettingState state) {
    return state.toJson();
  }

  FutureOr<void> _resetCheckInSettingEvent(
      ResetCheckInSettingEvent event, Emitter<CheckInSettingState> emit) {
    emit(const CheckInSettingState());
  }
}
