import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/draft_app/draft_note.dart';
import 'package:base_app/data/models/note/create_note_request.dart';
import 'package:base_app/data/models/note/get_draft_note_request.dart';
import 'package:base_app/data/models/note/get_notes_request.dart';
import 'package:base_app/data/models/note/update_note_request.dart';
import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/domain/repositories/note.repositories.dart';
import 'package:base_app/domain/services/note.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NoteRepository)
class NoteRepositoryImpl extends NoteRepository {
  final NoteService noteService;

  NoteRepositoryImpl() : noteService = dI<NoteService>();

  @override
  Future<int> createNoteRequest({required String note, required String dateTime}) async {
    return await noteService.createNoteRequest(
        createNoteRequest: CreateNoteRequest(note: note, dateTime: dateTime));
  }

  @override
  Future<Note> getNoteByIdRequest({required String id}) async {
    return await noteService.getNoteByIdRequest(
      getNoteByIdRequest: ObjectByIdRequest(id: id),
    );
  }

  @override
  Future<List<Note>> getNotesRequest({required String startDate, required String endDate}) async {
    return await noteService.getNotesRequest(
        getNotesRequest: GetNotesRequest(startDate: startDate, endDate: endDate));
  }

  @override
  Future<int> updateNoteRequest(
      {required String note, required String id, required String dateTime}) async {
    return await noteService.updateNoteRequest(
        updateNoteRequest: UpdateNoteRequest(id: id, note: note, dateTime: dateTime));
  }

  @override
  Future<int> deleteNoteByIdRequest({required String id}) async {
    return await noteService.deleteNoteByIdRequest(
        deleteNoteByIdRequest: ObjectByIdRequest(id: id));
  }

  @override
  Future<List<DraftNote>> getAttendances(
      {required String userId, required int month, required int year}) async {
    return await noteService.getAttendances(
      getDraftNoteRequest: GetDraftNoteRequest(
        userId: userId,
        year: year,
        month: month,
      ),
    );
  }
}
