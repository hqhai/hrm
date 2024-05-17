import 'package:base_app/data/models/note/create_note_request.dart';
import 'package:base_app/data/models/note/get_notes_request.dart';
import 'package:base_app/data/models/note/update_note_request.dart';
import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/domain/entities/note.dart';

abstract class NoteService {
  Future<int> createNoteRequest({required CreateNoteRequest createNoteRequest});

  Future<int> updateNoteRequest({required UpdateNoteRequest updateNoteRequest});

  Future<Note> getNoteByIdRequest({required ObjectByIdRequest getNoteByIdRequest});

  Future<List<Note>> getNotesRequest({required GetNotesRequest getNotesRequest});

  Future<int> deleteNoteByIdRequest({required ObjectByIdRequest deleteNoteByIdRequest});
}
