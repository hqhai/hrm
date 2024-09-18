import 'package:base_app/common/utils/date_time_json.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_note_request.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class CreateNoteRequest {
  final String note;
  final DateTime dateTime;

  const CreateNoteRequest(
      {required this.dateTime,
        required this.note,
        });

  factory CreateNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNoteRequestToJson(this);
}
