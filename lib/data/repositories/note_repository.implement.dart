import 'package:base_app/data/models/draft_app/draft_note.dart';
import 'package:base_app/data/models/note/create_note_request.dart';
import 'package:base_app/data/models/note/get_draft_note_request.dart';
import 'package:base_app/data/models/note/get_notes_request.dart';
import 'package:base_app/data/models/note/update_note_request.dart';
import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/domain/repositories/note.repositories.dart';
import 'package:injectable/injectable.dart';

import '../source/api/services/note_service.dart';

@LazySingleton(as: NoteRepository)
class NoteRepositoryImpl extends NoteRepository {
  final NoteService _noteService;

  NoteRepositoryImpl(this._noteService);

  @override
  Future<int?> createNoteRequest({required String note, required DateTime dateTime}) async {
    final data = await _noteService.createNoteRequest(createNoteRequest: CreateNoteRequest(note: note, dateTime: dateTime));
    return data?.statusCode;
  }

  @override
  Future<Note?> getNoteByIdRequest({required String id}) async {
    final response = await _noteService.getNoteByIdRequest(
      getNoteByIdRequest: ObjectByIdRequest(id: id),
    );
    return response?.data;
  }

  @override
  Future<List<Note>?> getNotesRequest({required String startDate, required String endDate}) async {
    final response = await _noteService.getNotesRequest(getNotesRequest: GetNotesRequest(startDate: startDate, endDate: endDate));
    return response?.result;
  }

  @override
  Future<int?> updateNoteRequest({required String note, required String id, required DateTime dateTime}) async {
    final response = await _noteService.updateNoteRequest(updateNoteRequest: UpdateNoteRequest(id: id, note: note, dateTime: dateTime));
    return response?.statusCode;
  }

  @override
  Future<int?> deleteNoteByIdRequest({required String id}) async {
    final response = await _noteService.deleteNoteByIdRequest(deleteNoteByIdRequest: ObjectByIdRequest(id: id));
    return response?.statusCode;
  }

  @override
  Future<List<DraftNote>?> getAttendances({required String userId, required int month, required int year}) async {
    final response = await _noteService.getAttendances(
      getDraftNoteRequest: GetDraftNoteRequest(
        userId: userId,
        year: year,
        month: month,
      ),
    );
    return response?.result;
  }
}
