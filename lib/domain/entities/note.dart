import 'package:base_app/common/enum/enum_config.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@CopyWith()
@JsonSerializable()
class Note {
  final String title;
  final String content;
  final String dateCreate;

  const Note(
      {
      this.title = '',
      this.content = '',
      this.dateCreate = '',});

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
