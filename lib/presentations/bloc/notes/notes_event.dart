import 'package:equatable/equatable.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

class CreateNotesEvent extends NotesEvent {
  const CreateNotesEvent({required this.note, required this.dateTime});

  final String note;
  final DateTime dateTime;

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

class GetCalenderEvent extends NotesEvent {
  const GetCalenderEvent({required this.month, required this.year, required this.userId});

  final String userId;
  final int month;
  final int year;

  @override
  List<Object?> get props => [userId, month, year];
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

class ResetNotesEvent extends NotesEvent {
  const ResetNotesEvent();

  @override
  List<Object> get props => [];
}
