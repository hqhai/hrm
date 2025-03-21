// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NoteCWProxy {
  Note note(String note);

  Note dateTime(DateTime? dateTime);

  Note id(String id);

  Note createdUserId(String createdUserId);

  Note updatedUserId(String updatedUserId);

  Note createdFullName(String createdFullName);

  Note updatedFullName(String updatedFullName);

  Note createdDate(String createdDate);

  Note updatedDate(String updatedDate);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Note(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Note(...).copyWith(id: 12, name: "My name")
  /// ````
  Note call({
    String? note,
    DateTime? dateTime,
    String? id,
    String? createdUserId,
    String? updatedUserId,
    String? createdFullName,
    String? updatedFullName,
    String? createdDate,
    String? updatedDate,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNote.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNote.copyWith.fieldName(...)`
class _$NoteCWProxyImpl implements _$NoteCWProxy {
  const _$NoteCWProxyImpl(this._value);

  final Note _value;

  @override
  Note note(String note) => this(note: note);

  @override
  Note dateTime(DateTime? dateTime) => this(dateTime: dateTime);

  @override
  Note id(String id) => this(id: id);

  @override
  Note createdUserId(String createdUserId) =>
      this(createdUserId: createdUserId);

  @override
  Note updatedUserId(String updatedUserId) =>
      this(updatedUserId: updatedUserId);

  @override
  Note createdFullName(String createdFullName) =>
      this(createdFullName: createdFullName);

  @override
  Note updatedFullName(String updatedFullName) =>
      this(updatedFullName: updatedFullName);

  @override
  Note createdDate(String createdDate) => this(createdDate: createdDate);

  @override
  Note updatedDate(String updatedDate) => this(updatedDate: updatedDate);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Note(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Note(...).copyWith(id: 12, name: "My name")
  /// ````
  Note call({
    Object? note = const $CopyWithPlaceholder(),
    Object? dateTime = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? createdUserId = const $CopyWithPlaceholder(),
    Object? updatedUserId = const $CopyWithPlaceholder(),
    Object? createdFullName = const $CopyWithPlaceholder(),
    Object? updatedFullName = const $CopyWithPlaceholder(),
    Object? createdDate = const $CopyWithPlaceholder(),
    Object? updatedDate = const $CopyWithPlaceholder(),
  }) {
    return Note(
      note: note == const $CopyWithPlaceholder() || note == null
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String,
      dateTime: dateTime == const $CopyWithPlaceholder()
          ? _value.dateTime
          // ignore: cast_nullable_to_non_nullable
          : dateTime as DateTime?,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      createdUserId:
          createdUserId == const $CopyWithPlaceholder() || createdUserId == null
              ? _value.createdUserId
              // ignore: cast_nullable_to_non_nullable
              : createdUserId as String,
      updatedUserId:
          updatedUserId == const $CopyWithPlaceholder() || updatedUserId == null
              ? _value.updatedUserId
              // ignore: cast_nullable_to_non_nullable
              : updatedUserId as String,
      createdFullName: createdFullName == const $CopyWithPlaceholder() ||
              createdFullName == null
          ? _value.createdFullName
          // ignore: cast_nullable_to_non_nullable
          : createdFullName as String,
      updatedFullName: updatedFullName == const $CopyWithPlaceholder() ||
              updatedFullName == null
          ? _value.updatedFullName
          // ignore: cast_nullable_to_non_nullable
          : updatedFullName as String,
      createdDate:
          createdDate == const $CopyWithPlaceholder() || createdDate == null
              ? _value.createdDate
              // ignore: cast_nullable_to_non_nullable
              : createdDate as String,
      updatedDate:
          updatedDate == const $CopyWithPlaceholder() || updatedDate == null
              ? _value.updatedDate
              // ignore: cast_nullable_to_non_nullable
              : updatedDate as String,
    );
  }
}

extension $NoteCopyWith on Note {
  /// Returns a callable class that can be used as follows: `instanceOfNote.copyWith(...)` or like so:`instanceOfNote.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NoteCWProxy get copyWith => _$NoteCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      note: json['note'] as String? ?? '',
      dateTime: _$JsonConverterFromJson<String, DateTime>(
          json['dateTime'], const CustomDateTimeConverter().fromJson),
      id: json['id'] as String? ?? '',
      createdUserId: json['createdUserId'] as String? ?? '',
      updatedUserId: json['updatedUserId'] as String? ?? '',
      createdFullName: json['createdFullName'] as String? ?? '',
      updatedFullName: json['updatedFullName'] as String? ?? '',
      createdDate: json['createdDate'] as String? ?? '',
      updatedDate: json['updatedDate'] as String? ?? '',
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'note': instance.note,
      if (_$JsonConverterToJson<String, DateTime>(
              instance.dateTime, const CustomDateTimeConverter().toJson)
          case final value?)
        'dateTime': value,
      'id': instance.id,
      'createdUserId': instance.createdUserId,
      'updatedUserId': instance.updatedUserId,
      'createdFullName': instance.createdFullName,
      'updatedFullName': instance.updatedFullName,
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
