// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      dateCreate: json['dateCreate'] as String? ?? '',
      status: $enumDecodeNullable(_$NoteStatusEnumMap, json['status']) ??
          NoteStatus.init,
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'dateCreate': instance.dateCreate,
      'status': _$NoteStatusEnumMap[instance.status]!,
    };

const _$NoteStatusEnumMap = {
  NoteStatus.init: 'init',
  NoteStatus.createNoteInit: 'createNoteInit',
  NoteStatus.createNoteSuccess: 'createNoteSuccess',
  NoteStatus.createNoteError: 'createNoteError',
  NoteStatus.getNoteInit: 'getNoteInit',
  NoteStatus.getNoteSuccess: 'getNoteSuccess',
  NoteStatus.getNoteError: 'getNoteError',
  NoteStatus.updateNoteInit: 'updateNoteInit',
  NoteStatus.updateNoteSuccess: 'updateNoteSuccess',
  NoteStatus.updateNoteError: 'updateNoteError',
  NoteStatus.deleteNoteInit: 'deleteNoteInit',
  NoteStatus.deleteNoteSuccess: 'deleteNoteSuccess',
  NoteStatus.deleteNoteError: 'deleteNoteError',
  NoteStatus.expired: 'expired',
  NoteStatus.complete: 'complete',
  NoteStatus.unfinished: 'unfinished',
};
