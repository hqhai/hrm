import 'package:base_app/common/utils/date_time_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_note_request.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class UpdateNoteRequest {
  final String id;
  final String note;
  final DateTime dateTime;

  const UpdateNoteRequest(
      {required this.id,
        required this.note,
        required this.dateTime
        });

  factory UpdateNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateNoteRequestToJson(this);
}
