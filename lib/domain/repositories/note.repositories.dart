import 'package:base_app/data/models/draft_app/draft_note.dart';
import 'package:base_app/domain/entities/note.dart';

abstract class NoteRepository {
  Future<int> createNoteRequest({required String note, required DateTime dateTime});

  Future<int> updateNoteRequest({required String note, required String id, required DateTime dateTime});

  Future<Note> getNoteByIdRequest({required String id});

  Future<List<Note>> getNotesRequest({required String startDate, required String endDate});

  Future<int> deleteNoteByIdRequest({required String id});

  Future<List<DraftNote>> getAttendances({
    required String userId,
    required int month,
    required int year,
  });
}
