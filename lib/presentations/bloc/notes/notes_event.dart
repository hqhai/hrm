import 'package:equatable/equatable.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

class CreateNotesEvent extends NotesEvent {
  const CreateNotesEvent({required this.note, required this.dateTime});

  final String note;
  final String dateTime;

  @override
  List<Object?> get props => [note];
}

class UpdateNotesEvent extends NotesEvent {
  const UpdateNotesEvent({required this.note, required this.id, required this.dateTime});

  final String note;
  final String id;
  final String dateTime;

  @override
  List<Object?> get props => [note, id, dateTime];
}

class GetNotesEvent extends NotesEvent {
  const GetNotesEvent({required this.startDate, required this.endDate});

  final String startDate;
  final String endDate;

  @override
  List<Object?> get props => [startDate, endDate];
}

class GetNoteByIdEvent extends NotesEvent {
  const GetNoteByIdEvent({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}

class DeleteNoteEvent extends NotesEvent {
  const DeleteNoteEvent({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}

class ResetNoteEvent extends NotesEvent {
  const ResetNoteEvent();

  @override
  List<Object?> get props => [];
}
