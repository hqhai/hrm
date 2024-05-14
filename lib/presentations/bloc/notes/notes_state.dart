import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notes_state.g.dart';

@CopyWith()
@JsonSerializable()
class NotesState extends Equatable {
  const NotesState({this.notes = const [], this.status = NoteStatus.init});

  final List<Note> notes;
  final NoteStatus status;

  @override
  List<Object> get props => [];

  factory NotesState.fromJson(Map<String, dynamic> json) => _$NotesStateFromJson(json);

  Map<String, dynamic> toJson() => _$NotesStateToJson(this);
}
