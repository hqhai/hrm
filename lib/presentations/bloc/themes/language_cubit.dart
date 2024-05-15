import 'package:base_app/common/enum/value_string.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

@lazySingleton
class LanguageCubit extends HydratedCubit<LanguageEnum> {
  LanguageCubit() : super(LanguageEnum.en);

  void changeLocale(LanguageEnum languageCode) => emit(languageCode);

  @override
  LanguageEnum? fromJson(Map<String, dynamic> json) {
    return $enumDecode(_$LanguageEnumMap, json['languageCode']);
  }

  @override
  Map<String, dynamic>? toJson(LanguageEnum state) {
    return <String, dynamic>{'status': _$LanguageEnumMap[state]!};
  }
}

const _$LanguageEnumMap = {
  LanguageEnum.vi: 'vi',
  LanguageEnum.en: 'en',
};
