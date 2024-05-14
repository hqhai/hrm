import 'package:base_app/common/enum/enum_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {
  final String id;
  final String title;
  final String content;
  final String dateCreate;
  final NoteStatus status;

  const Note(
      {
      this.id = '',
      this.title = '',
      this.content = '',
      this.dateCreate = '',
      this.status = NoteStatus.init});

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
