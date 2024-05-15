import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@CopyWith()
@JsonSerializable()
class Note {
  final String note;
  final String dateTime;
  final String id;
  final String createdUserId;
  final String? updatedUserId;
  final String createdFullName;
  final String? updatedFullName;
  final String createdDate;
  final String? updatedDate;

  const Note({
    required this.note,
    required this.dateTime,
    required this.id,
    required this.createdUserId,
    this.updatedUserId,
    required this.createdFullName,
    this.updatedFullName,
    required this.createdDate,
    this.updatedDate,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
