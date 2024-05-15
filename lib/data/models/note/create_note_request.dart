import 'package:json_annotation/json_annotation.dart';

part 'create_note_request.g.dart';

@JsonSerializable()
class CreateNoteRequest {
  final String note;
  final String dateTime;

  const CreateNoteRequest(
      {required this.dateTime,
        required this.note,
        });

  factory CreateNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNoteRequestToJson(this);
}
