import 'package:json_annotation/json_annotation.dart';

part 'draft_note.g.dart';

@JsonSerializable()
class DraftNote {
  final String attendanceDate;
  final int checkIn;
  final int checkOut;
  final String note;

  const DraftNote({this.note = '', this.checkOut = 0, this.checkIn = 0, this.attendanceDate = ''});

  factory DraftNote.fromJson(Map<String, dynamic> json) => _$DraftNoteFromJson(json);

  Map<String, dynamic> toJson() => _$DraftNoteToJson(this);
}
