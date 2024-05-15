// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NoteCWProxy {
  Note createdDate(String createdDate);

  Note createdFullName(String createdFullName);

  Note createdUserId(String createdUserId);

  Note dateTime(String dateTime);

  Note id(String id);

  Note note(String note);

  Note updatedDate(String? updatedDate);

  Note updatedFullName(String? updatedFullName);

  Note updatedUserId(String? updatedUserId);

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
    String? dateTime,
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
  Note dateTime(String dateTime) => this(dateTime: dateTime);

  @override
  Note id(String id) => this(id: id);

  @override
  Note note(String note) => this(note: note);

  @override
  Note updatedDate(String? updatedDate) => this(updatedDate: updatedDate);

  @override
  Note updatedFullName(String? updatedFullName) =>
      this(updatedFullName: updatedFullName);

  @override
  Note updatedUserId(String? updatedUserId) =>
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
      dateTime: dateTime == const $CopyWithPlaceholder() || dateTime == null
          ? _value.dateTime
          // ignore: cast_nullable_to_non_nullable
          : dateTime as String,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      note: note == const $CopyWithPlaceholder() || note == null
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String,
      updatedDate: updatedDate == const $CopyWithPlaceholder()
          ? _value.updatedDate
          // ignore: cast_nullable_to_non_nullable
          : updatedDate as String?,
      updatedFullName: updatedFullName == const $CopyWithPlaceholder()
          ? _value.updatedFullName
          // ignore: cast_nullable_to_non_nullable
          : updatedFullName as String?,
      updatedUserId: updatedUserId == const $CopyWithPlaceholder()
          ? _value.updatedUserId
          // ignore: cast_nullable_to_non_nullable
          : updatedUserId as String?,
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
      note: json['note'] as String,
      dateTime: json['dateTime'] as String,
      id: json['id'] as String,
      createdUserId: json['createdUserId'] as String,
      updatedUserId: json['updatedUserId'] as String?,
      createdFullName: json['createdFullName'] as String,
      updatedFullName: json['updatedFullName'] as String?,
      createdDate: json['createdDate'] as String,
      updatedDate: json['updatedDate'] as String?,
    );

Map<String, dynamic> _$NoteToJson(Note instance) {
  final val = <String, dynamic>{
    'note': instance.note,
    'dateTime': instance.dateTime,
    'id': instance.id,
    'createdUserId': instance.createdUserId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('updatedUserId', instance.updatedUserId);
  val['createdFullName'] = instance.createdFullName;
  writeNotNull('updatedFullName', instance.updatedFullName);
  val['createdDate'] = instance.createdDate;
  writeNotNull('updatedDate', instance.updatedDate);
  return val;
}
