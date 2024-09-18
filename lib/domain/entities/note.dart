import 'package:base_app/common/utils/date_time_json.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@CopyWith()
@JsonSerializable()
@CustomDateTimeConverter()
class Note {
  final String note;
  final DateTime? dateTime;
  final String id;
  final String createdUserId;
  final String updatedUserId;
  final String createdFullName;
  final String updatedFullName;
  final String createdDate;
  final String updatedDate;

  const Note({
    this.note = '',
    this.dateTime,
    this.id = '',
    this.createdUserId = '',
    this.updatedUserId = '',
    this.createdFullName = '',
    this.updatedFullName = '',
    this.createdDate = '',
    this.updatedDate = '',
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
