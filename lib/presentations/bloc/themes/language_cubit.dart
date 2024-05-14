import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LanguageCubit extends HydratedCubit<String> {
  LanguageCubit() : super('en');

  void changeLocale(String languageCode) => emit(languageCode);

  @override
  String? fromJson(Map<String, dynamic> json) {
    return json['languageCode'];
  }

  @override
  Map<String, dynamic>? toJson(String state) {
    return {'languageCode': state};
  }
}
