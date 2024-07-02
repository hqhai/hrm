import 'package:json_annotation/json_annotation.dart';

part 'start_end.g.dart';

@JsonSerializable()
class StartEndResponse {
  final String startTime;
  final String endTime;

  const StartEndResponse(
      {this.startTime = '', this.endTime = ''});

  factory StartEndResponse.fromJson(Map<String, dynamic> json) =>
      _$StartEndResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StartEndResponseToJson(this);
}
