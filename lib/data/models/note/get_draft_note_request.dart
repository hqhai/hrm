import 'package:json_annotation/json_annotation.dart';

part 'get_draft_note_request.g.dart';

@JsonSerializable()
class GetDraftNoteRequest {
  final String userId;
  final int month;
  final int year;

  const GetDraftNoteRequest(
      {required this.userId,
        required this.month,
        required this.year
        });

  factory GetDraftNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$GetDraftNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetDraftNoteRequestToJson(this);
}
