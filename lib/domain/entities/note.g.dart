// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NoteCWProxy {
  Note createdDate(String createdDate);

  Note createdFullName(String createdFullName);

  Note createdUserId(String createdUserId);

  Note dateTime(DateTime? dateTime);

  Note id(String id);

  Note note(String note);

  Note updatedDate(String updatedDate);

  Note updatedFullName(String updatedFullName);

  Note updatedUserId(String updatedUserId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Note(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Note(...).copyWith(id: 12, name: "My name")
  /// ````
  Note call({
    String? createdDate,
    String? createdFullName,
    String? createdUserId,
    DateTime? dateTime,
    String? id,
    String? note,
    String? updatedDate,
    String? updatedFullName,
    String? updatedUserId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNote.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNote.copyWith.fieldName(...)`
class _$NoteCWProxyImpl implements _$NoteCWProxy {
  final Note _value;

  const _$NoteCWProxyImpl(this._value);

  @override
  Note createdDate(String createdDate) => this(createdDate: createdDate);

  @override
  Note createdFullName(String createdFullName) =>
      this(createdFullName: createdFullName);

  @override
  Note createdUserId(String createdUserId) =>
      this(createdUserId: createdUserId);

  @override
  Note dateTime(DateTime? dateTime) => this(dateTime: dateTime);

  @override
  Note id(String id) => this(id: id);

  @override
  Note note(String note) => this(note: note);

  @override
  Note updatedDate(String updatedDate) => this(updatedDate: updatedDate);

  @override
  Note updatedFullName(String updatedFullName) =>
      this(updatedFullName: updatedFullName);

  @override
  Note updatedUserId(String updatedUserId) =>
      this(updatedUserId: updatedUserId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Note(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Note(...).copyWith(id: 12, name: "My name")
  /// ````
  Note call({
    Object? createdDate = const $CopyWithPlaceholder(),
    Object? createdFullName = const $CopyWithPlaceholder(),
    Object? createdUserId = const $CopyWithPlaceholder(),
    Object? dateTime = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? updatedDate = const $CopyWithPlaceholder(),
    Object? updatedFullName = const $CopyWithPlaceholder(),
    Object? updatedUserId = const $CopyWithPlaceholder(),
  }) {
    return Note(
      createdDate:
          createdDate == const $CopyWithPlaceholder() || createdDate == null
              ? _value.createdDate
              // ignore: cast_nullable_to_non_nullable
              : createdDate as String,
      createdFullName: createdFullName == const $CopyWithPlaceholder() ||
              createdFullName == null
          ? _value.createdFullName
          // ignore: cast_nullable_to_non_nullable
          : createdFullName as String,
      createdUserId:
          createdUserId == const $CopyWithPlaceholder() || createdUserId == null
              ? _value.createdUserId
              // ignore: cast_nullable_to_non_nullable
              : createdUserId as String,
      dateTime: dateTime == const $CopyWithPlaceholder()
          ? _value.dateTime
          // ignore: cast_nullable_to_non_nullable
          : dateTime as DateTime?,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      note: note == const $CopyWithPlaceholder() || note == null
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String,
      updatedDate:
          updatedDate == const $CopyWithPlaceholder() || updatedDate == null
              ? _value.updatedDate
              // ignore: cast_nullable_to_non_nullable
              : updatedDate as String,
      updatedFullName: updatedFullName == const $CopyWithPlaceholder() ||
              updatedFullName == null
          ? _value.updatedFullName
          // ignore: cast_nullable_to_non_nullable
          : updatedFullName as String,
      updatedUserId:
          updatedUserId == const $CopyWithPlaceholder() || updatedUserId == null
              ? _value.updatedUserId
              // ignore: cast_nullable_to_non_nullable
              : updatedUserId as String,
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

Map<String, dynamic> _$NoteToJson(Note instance) {
  final val = <String, dynamic>{
    'note': instance.note,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'dateTime',
      _$JsonConverterToJson<String, DateTime>(
          instance.dateTime, const CustomDateTimeConverter().toJson));
  val['id'] = instance.id;
  val['createdUserId'] = instance.createdUserId;
  val['updatedUserId'] = instance.updatedUserId;
  val['createdFullName'] = instance.createdFullName;
  val['updatedFullName'] = instance.updatedFullName;
  val['createdDate'] = instance.createdDate;
  val['updatedDate'] = instance.updatedDate;
  return val;
}

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
