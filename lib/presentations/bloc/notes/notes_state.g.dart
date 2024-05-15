// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotesStateCWProxy {
  NotesState note(Note note);

  NotesState notes(List<Note> notes);

  NotesState status(NoteStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotesState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotesState(...).copyWith(id: 12, name: "My name")
  /// ````
  NotesState call({
    Note? note,
    List<Note>? notes,
    NoteStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotesState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotesState.copyWith.fieldName(...)`
class _$NotesStateCWProxyImpl implements _$NotesStateCWProxy {
  final NotesState _value;

  const _$NotesStateCWProxyImpl(this._value);

  @override
  NotesState note(Note note) => this(note: note);

  @override
  NotesState notes(List<Note> notes) => this(notes: notes);

  @override
  NotesState status(NoteStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotesState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotesState(...).copyWith(id: 12, name: "My name")
  /// ````
  NotesState call({
    Object? note = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return NotesState(
      note: note == const $CopyWithPlaceholder() || note == null
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as Note,
      notes: notes == const $CopyWithPlaceholder() || notes == null
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as List<Note>,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as NoteStatus,
    );
  }
}

extension $NotesStateCopyWith on NotesState {
  /// Returns a callable class that can be used as follows: `instanceOfNotesState.copyWith(...)` or like so:`instanceOfNotesState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotesStateCWProxy get copyWith => _$NotesStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotesState _$NotesStateFromJson(Map<String, dynamic> json) => NotesState(
      notes: (json['notes'] as List<dynamic>?)
              ?.map((e) => Note.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      note: json['note'] == null
          ? const Note(
              id: '',
              dateTime: '',
              note: '',
              createdFullName: '',
              createdDate: '',
              createdUserId: '')
          : Note.fromJson(json['note'] as Map<String, dynamic>),
      status: $enumDecodeNullable(_$NoteStatusEnumMap, json['status']) ??
          NoteStatus.init,
    );

Map<String, dynamic> _$NotesStateToJson(NotesState instance) =>
    <String, dynamic>{
      'notes': instance.notes,
      'note': instance.note,
      'status': _$NoteStatusEnumMap[instance.status]!,
    };

const _$NoteStatusEnumMap = {
  NoteStatus.init: 'init',
  NoteStatus.createNoteInit: 'createNoteInit',
  NoteStatus.createNoteSuccess: 'createNoteSuccess',
  NoteStatus.createNoteError: 'createNoteError',
  NoteStatus.createNoteErrorAlreadyExistOnDay:
      'createNoteErrorAlreadyExistOnDay',
  NoteStatus.getNoteInit: 'getNoteInit',
  NoteStatus.getNoteSuccess: 'getNoteSuccess',
  NoteStatus.getNoteError: 'getNoteError',
  NoteStatus.getNotesInit: 'getNotesInit',
  NoteStatus.getNotesSuccess: 'getNotesSuccess',
  NoteStatus.getNotesError: 'getNotesError',
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
