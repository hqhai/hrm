import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/base/data_response.dart';
import 'package:base_app/data/models/draft_app/draft_note.dart';
import 'package:base_app/data/models/note/create_note_request.dart';
import 'package:base_app/data/models/note/get_draft_note_request.dart';
import 'package:base_app/data/models/note/get_notes_request.dart';
import 'package:base_app/data/models/note/update_note_request.dart';
import 'package:base_app/data/models/object_by_id_request.dart';
import 'package:base_app/data/source/api/client/base/rest_client_base.dart';
import 'package:base_app/data/source/api/client/user_api_client.dart';
import 'package:base_app/data/source/api/mapper/base_success_response_mapper.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class NoteService {
  final UserApiClient _userApiClient;

  NoteService(
    this._userApiClient,
  );

  Future<DataResponse?> createNoteRequest(
      {required CreateNoteRequest createNoteRequest}) async {
    return _userApiClient.request(
      method: RestMethod.post,
      path: PathConfig.note,
      queryParameters: createNoteRequest.toJson(),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<Note>?> getNoteByIdRequest(
      {required ObjectByIdRequest getNoteByIdRequest}) async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: '${PathConfig.note}/${getNoteByIdRequest.id}',
      decoder: (json) => Note.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataListResponse<Note>?> getNotesRequest(
      {required GetNotesRequest getNotesRequest}) async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: PathConfig.note,
      queryParameters: getNotesRequest.toJson(),
      decoder: (json) => Note.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
    );
  }

  Future<DataResponse?> updateNoteRequest(
      {required UpdateNoteRequest updateNoteRequest}) async {
    return _userApiClient.request(
      method: RestMethod.put,
      path: PathConfig.note,
      body: updateNoteRequest.toJson(),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse?> deleteNoteByIdRequest(
      {required ObjectByIdRequest deleteNoteByIdRequest}) async {
    return _userApiClient.request(
      method: RestMethod.delete,
      path: '${PathConfig.note}/${deleteNoteByIdRequest.id}',
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataListResponse<DraftNote>?> getAttendances(
      {required GetDraftNoteRequest getDraftNoteRequest}) async {
    return _userApiClient.request(
      method: RestMethod.get,
      path: PathConfig.getAttendance,
      queryParameters: getDraftNoteRequest.toJson(),
      decoder: (json) => DraftNote.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
    );
  }
}
