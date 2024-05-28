import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/presentations/bloc/biometric/biometric_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
@lazySingleton
class BiometricCubit extends HydratedCubit<BiometricState> {
  BiometricCubit() : super(const BiometricState(status: BiometricEnum.notRegistered));

  void changeBiometric(BiometricState biometricState) => emit(biometricState);

  @override
  BiometricState? fromJson(Map<String, dynamic> json) {
    return BiometricState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(BiometricState state) {
    return state.toJson();
  }
}
