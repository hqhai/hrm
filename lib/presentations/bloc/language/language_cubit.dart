import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
@lazySingleton
class LanguageCubit extends HydratedCubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(languageCode: LanguageEnum.en));

  void changeLocale(LanguageEnum languageCode) => emit(LanguageState(languageCode: languageCode));

  @override
  LanguageState? fromJson(Map<String, dynamic> json) {
    return LanguageState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) {
    return state.toJson();
  }

/*@override
  LanguageEnum? fromJson(Map<String, dynamic> json) {
    return $enumDecode(_$LanguageCodeEnumMap, json['languageCode']);
  }

  @override
  Map<String, dynamic>? toJson(LanguageEnum state) {
    return <String, dynamic>{'status': _$LanguageCodeEnumMap[state]!};
  }*/
}

const _$LanguageCodeEnumMap = {
  LanguageEnum.vi: 'vi',
  LanguageEnum.en: 'en',
};

