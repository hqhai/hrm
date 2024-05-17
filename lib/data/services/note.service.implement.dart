import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/note/create_note_request.dart';
import 'package:base_app/data/models/note/get_notes_request.dart';
import 'package:base_app/data/models/note/update_note_request.dart';
import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/domain/services/note.service.dart';
import 'package:injectable/injectable.dart';

import 'base.service.dart';

@LazySingleton(as: NoteService)
class NoteServiceImpl extends BaseService implements NoteService {
  late String baseUrl;
  late String baseUrlUser;

  NoteServiceImpl() : super() {
    baseUrl = appConfig.baseAuthUrl;
    baseUrlUser = appConfig.baseUserUrl;
  }

  @override
  Future<int> createNoteRequest({required CreateNoteRequest createNoteRequest}) async {
    final url = '$baseUrlUser${PathConfig.note}';
    final body = jsonEncode(createNoteRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    int statusCode = responseBase.statusCode;
    return statusCode;
  }

  @override
  Future<Note> getNoteByIdRequest({required ObjectByIdRequest getNoteByIdRequest}) async {
    final url = '$baseUrlUser${PathConfig.note}/${getNoteByIdRequest.id}';
    final response = await client.get(url,);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    Note note = Note.fromJson(data);
    return note;
  }

  @override
  Future<List<Note>> getNotesRequest({required GetNotesRequest getNotesRequest}) async {
    final url = '$baseUrlUser${PathConfig.note}';
    final params = getNotesRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    List<Note> notes = (data as List<dynamic>).map((e) => Note.fromJson(e as Map<String, dynamic>)).toList();
    return notes;
  }

  @override
  Future<int> updateNoteRequest({required UpdateNoteRequest updateNoteRequest}) async {
    final url = '$baseUrlUser${PathConfig.note}';
    final body = jsonEncode(updateNoteRequest.toJson());
    final response = await client.put(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    int statusCode = responseBase.statusCode;
    return statusCode;
  }

  @override
  Future<int> deleteNoteByIdRequest({required ObjectByIdRequest deleteNoteByIdRequest}) async {
    final url = '$baseUrlUser${PathConfig.note}/${deleteNoteByIdRequest.id}';
    final response = await client.delete(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    int statusCode = responseBase.statusCode;
    return statusCode;
  }
}
