

import 'package:base_app/domain/entities/note.dart';
import 'package:equatable/equatable.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

class CreateNotesEvent extends NotesEvent {
  const CreateNotesEvent({required this.note});
  final Note note;

  @override
  List<Object?> get props => [note];
}
