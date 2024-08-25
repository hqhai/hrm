import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/draft_app/draft_note.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/domain/repositories/note.repositories.dart';
import 'package:base_app/domain/use_cases/note.usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NoteUseCase)
class NoteUseCaseImpl extends NoteUseCase {
  final NoteRepository _noteRepository;

  NoteUseCaseImpl() : _noteRepository = dI<NoteRepository>();

  @override
  Future<int> createNoteRequest({required String note, required String dateTime}) async {
    return await _noteRepository.createNoteRequest(note: note, dateTime: dateTime);
  }

  @override
  Future<Note> getNoteByIdRequest({required String id}) async {
    return await _noteRepository.getNoteByIdRequest(id: id);
  }

  @override
  Future<List<Note>> getNotesRequest({required String startDate, required String endDate}) async {
    return await _noteRepository.getNotesRequest(startDate: startDate, endDate: endDate);
  }

  @override
  Future<int> updateNoteRequest({
    required String note,
    required String id,
    required String dateTime,
  }) async {
    return await _noteRepository.updateNoteRequest(note: note, id: id, dateTime: dateTime);
  }

  @override
  Future<int> deleteNoteByIdRequest({required String id}) async {
    return await _noteRepository.deleteNoteByIdRequest(id: id);
  }

  @override
  Future<List<DraftNote>> getAttendances(
      {required String userId, required int month, required int year}) async {
    return await _noteRepository.getAttendances(userId: userId, month: month, year: year);
  }
}
