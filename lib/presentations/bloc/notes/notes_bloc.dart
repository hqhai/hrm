import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/domain/use_cases/note.usecase.dart';
import 'package:base_app/presentations/bloc/notes/notes_event.dart';
import 'package:base_app/presentations/bloc/notes/notes_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NoteUseCase noteUseCase;

  NotesBloc()
      : noteUseCase = dI<NoteUseCase>(),
        super(const NotesState()) {
    on<NotesEvent>((event, emit) {});
    on<CreateNotesEvent>(_createNotesEvent);
    on<GetNotesEvent>(_getNotesEvent);
    on<GetNoteByIdEvent>(_getNoteByIdEvent);
    on<UpdateNotesEvent>(_updateNotesEvent);
    on<DeleteNoteEvent>(_deleteNotesEvent);
    on<ResetNoteEvent>(_resetNoteEvent);
  }

  FutureOr<void> _createNotesEvent(CreateNotesEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: NoteStatus.createNoteInit));
    try {
      await noteUseCase.createNoteRequest(note: event.note, dateTime: event.dateTime);
      emit(state.copyWith(status: NoteStatus.createNoteSuccess));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.createNoteError));
    }
  }

  FutureOr<void> _getNotesEvent(GetNotesEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: NoteStatus.getNotesInit));
    try {
      List<Note> notes =
          await noteUseCase.getNotesRequest(startDate: event.startDate, endDate: event.endDate);
      emit(state.copyWith(notes: notes, status: NoteStatus.getNotesSuccess));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.getNotesError));
    }
  }

  FutureOr<void> _updateNotesEvent(UpdateNotesEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: NoteStatus.updateNoteInit));
    try {
      await noteUseCase.updateNoteRequest(note: event.note, id: event.id, dateTime: event.dateTime);
      emit(state.copyWith(status: NoteStatus.updateNoteSuccess));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.updateNoteError));
    }
  }

  FutureOr<void> _deleteNotesEvent(DeleteNoteEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: NoteStatus.deleteNoteInit));
    try {
      await noteUseCase.deleteNoteByIdRequest(id: event.id);
      emit(state.copyWith(status: NoteStatus.deleteNoteSuccess));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.deleteNoteError));
    }
  }

  FutureOr<void> _getNoteByIdEvent(GetNoteByIdEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: NoteStatus.getNoteInit));
    try {
      Note note = await noteUseCase.getNoteByIdRequest(id: event.id);
      emit(state.copyWith(note: note, status: NoteStatus.getNoteSuccess));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.getNoteError));
    }
  }

  FutureOr<void> _resetNoteEvent(ResetNoteEvent event, Emitter<NotesState> emit) {
    emit(const NotesState(status: NoteStatus.reset));
  }
}
