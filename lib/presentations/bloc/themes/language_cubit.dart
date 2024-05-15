import 'package:base_app/common/enum/value_string.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

@lazySingleton
class LanguageCubit extends HydratedCubit<LanguageCodeEnum> {
  LanguageCubit() : super(LanguageCodeEnum.en);

  void changeLocale(LanguageCodeEnum languageCode) => emit(languageCode);

  @override
  LanguageCodeEnum? fromJson(Map<String, dynamic> json) {
    return $enumDecode(_$LanguageCodeEnumMap, json['languageCode']);
  }

  @override
  Map<String, dynamic>? toJson(LanguageCodeEnum state) {
    return <String, dynamic>{'status': _$LanguageCodeEnumMap[state]!};
  }
}

const _$LanguageCodeEnumMap = {
  LanguageCodeEnum.vi: 'vi',
  LanguageCodeEnum.en: 'en',
};


