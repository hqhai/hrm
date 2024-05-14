
import 'dart:async';

import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/presentations/bloc/notes/notes_event.dart';
import 'package:base_app/presentations/bloc/notes/notes_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';



@lazySingleton
class NotesBloc extends HydratedBloc<NotesEvent, NotesState> {
  NotesBloc() : super(const NotesState()) {
    on<NotesEvent>((event, emit) {});
    on<CreateNotesEvent>(_createNotesEvent);
  }

  FutureOr<void> _createNotesEvent(CreateNotesEvent event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: NoteStatus.createNoteInit));
    try{
      List<Note> notes = state.notes;
      List<String> noteDates = notes.map((e) => e.dateCreate.toString()).toList();
      if(!noteDates.contains(event.note.dateCreate)){
        notes.add(event.note);
        emit(state.copyWith(notes: notes, status: NoteStatus.createNoteSuccess));
      }
      else {
        emit(state.copyWith(notes: notes, status: NoteStatus.createNoteErrorAlreadyExistOnDay));
      }
    }catch (e){
      emit(state.copyWith(status: NoteStatus.createNoteError));
    }
  }

  @override
  NotesState? fromJson(Map<String, dynamic> json) {
    return NotesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NotesState state) {
    return state.toJson();
  }


}
