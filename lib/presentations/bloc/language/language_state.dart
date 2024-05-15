import 'package:base_app/common/enum/value_string.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'language_state.g.dart';

@JsonSerializable()
class LanguageState extends Equatable {
  const LanguageState({this.languageCode = LanguageEnum.en});
  final LanguageEnum languageCode;

  @override
  List<Object> get props => [languageCode];

  factory LanguageState.fromJson(Map<String, dynamic> json) => _$LanguageStateFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageStateToJson(this);
}
