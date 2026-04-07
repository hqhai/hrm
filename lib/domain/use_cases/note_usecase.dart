import 'package:base_app/domain/models/note/draft_note.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/domain/repositories/note.repositories.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class NoteUseCase {
  NoteUseCase(this._noteRepository);

  final NoteRepository _noteRepository;

  Future<int> createNoteRequest({
    required String note,
    required DateTime dateTime,
  }) async {
    final response = await _noteRepository.createNoteRequest(
      note: note,
      dateTime: dateTime,
    );
    return response ?? 0;
  }

  Future<Note> getNoteByIdRequest({required String id}) async {
    final response = await _noteRepository.getNoteByIdRequest(id: id);
    return response ?? const Note();
  }

  Future<List<Note>> getNotesRequest({
    required String startDate,
    required String endDate,
  }) async {
    final response = await _noteRepository.getNotesRequest(
      startDate: startDate,
      endDate: endDate,
    );
    return response ?? [];
  }

  Future<int> updateNoteRequest({
    required String note,
    required String id,
    required DateTime dateTime,
  }) async {
    final response = await _noteRepository.updateNoteRequest(
      note: note,
      id: id,
      dateTime: dateTime,
    );
    return response ?? 0;
  }

  Future<int> deleteNoteByIdRequest({required String id}) async {
    final response = await _noteRepository.deleteNoteByIdRequest(id: id);
    return response ?? 0;
  }

  Future<List<DraftNote>> getAttendances({
    required String userId,
    required int month,
    required int year,
  }) async {
    final response = await _noteRepository.getAttendances(userId: userId, month: month, year: year);
    return response ?? [];
  }
}
