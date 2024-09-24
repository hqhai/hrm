import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/domain/use_cases/note.usecase.dart';
import 'package:base_app/presentations/bloc/notes/notes_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class NoteSystemCubit extends HydratedCubit<NotesState> {
  final NoteUseCase noteUseCase;

  NoteSystemCubit()
      : noteUseCase = dI<NoteUseCase>(),
        super(const NotesState());

  FutureOr<void> createNotesLocalEvent(
      {String note = '', required DateTime dateTime}) async {
    emit(state.copyWith(status: NoteStatus.createNoteInit));
    try {
      final Note newNode = Note(
          id: const Uuid().toString(),
          createdDate: dateTime.toString(),
          dateTime: dateTime,
          createdFullName: 'local',
          note: note);
      final newNotes = List<Note>.from(state.notes); 
      newNotes.add(newNode);
      emit(state.copyWith(
          notes: newNotes, status: NoteStatus.createNoteSuccess));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.createNoteError));
    }
  }

  FutureOr<void> createNotesEvent(
      {String note = '', required DateTime dateTime}) async {
    emit(state.copyWith(status: NoteStatus.createNoteInit));
    try {
      await noteUseCase.createNoteRequest(note: note, dateTime: dateTime);
      emit(state.copyWith(status: NoteStatus.createNoteSuccess));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.createNoteError));
    }
  }

  FutureOr<void> getNotesEvent(
      {required DateTime startDate, required DateTime endDate}) async {
    emit(state.copyWith(status: NoteStatus.getNotesInit));
    try {
      final notes = await noteUseCase.getNotesRequest(
          startDate: startDate.toString(), endDate: endDate.toString());
      emit(state.copyWith(notes: notes, status: NoteStatus.getNotesSuccess));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.getNotesError));
    }
  }

  FutureOr<void> updateNotesEvent(
      {String note = '', String id = '', required DateTime dateTime}) async {
    emit(state.copyWith(status: NoteStatus.updateNoteInit));
    try {
      await noteUseCase.updateNoteRequest(
          note: note, id: id, dateTime: dateTime);
      final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
      List<Note> notes = state.notes;
      final index = state.notes.indexWhere((element) => element.id == id);
      notes[index] = notes[index].copyWith(note: note, dateTime: dateTime);
      emit(state.copyWith(status: NoteStatus.updateNoteSuccess, notes: notes));
      if (currentContext.mounted) {
        dI<AppNavigation>().popUtil(Pages.home, buildContext: currentContext);
      }
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.updateNoteError));
    }
  }

  FutureOr<void> deleteNotesEvent({String id = ''}) async {
    emit(state.copyWith(status: NoteStatus.deleteNoteInit));
    try {
      await noteUseCase.deleteNoteByIdRequest(id: id);
      final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
      List<Note> notes = state.notes;
      final index = state.notes.indexWhere((element) => element.id == id);
      notes.removeAt(index);
      emit(state.copyWith(status: NoteStatus.deleteNoteSuccess, notes: notes));
      if (currentContext.mounted) {
        dI<AppNavigation>().popUtil(Pages.home, buildContext: currentContext);
      }
      emit(state.copyWith(status: NoteStatus.deleteNoteSuccess));
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.deleteNoteError));
    }
  }

  FutureOr<void> changeSelectDate({required DateTime selectDate}) {
    emit(state.copyWith(selectDay: selectDate));
  }

  @override
  NotesState? fromJson(Map<String, dynamic> json) {
    return NotesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(NotesState state) {
    return state.toJson();
  }

  FutureOr<void> resetNotesEvent() {
    emit(const NotesState());
  }
}
