import 'package:base_app/common/enum/value_string.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LanguageCubit extends HydratedCubit<LanguageCodeEnum> {
  LanguageCubit() : super(LanguageCodeEnum.en);

  void changeLocale(LanguageCodeEnum languageCode) => emit(languageCode);

  @override
  LanguageCodeEnum? fromJson(Map<String, dynamic> json) {
    return json['languageCode'];
  }

  @override
  Map<String, dynamic>? toJson(LanguageCodeEnum state) {
    return {'languageCode': state};
  }
}
