// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBase _$ResponseBaseFromJson(Map<String, dynamic> json) => ResponseBase(
      result: json['result'],
      errorMessages: (json['errorMessages'] as List<dynamic>?)
              ?.map((e) => ErrorMessages.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 404,
    );

Map<String, dynamic> _$ResponseBaseToJson(ResponseBase instance) =>
    <String, dynamic>{
      if (instance.result case final value?) 'result': value,
      'errorMessages': instance.errorMessages,
      'statusCode': instance.statusCode,
    };

ErrorMessages _$ErrorMessagesFromJson(Map<String, dynamic> json) =>
    ErrorMessages(
      errorCode: json['errorCode'] as String?,
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => Errors.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ErrorMessagesToJson(ErrorMessages instance) =>
    <String, dynamic>{
      if (instance.errorCode case final value?) 'errorCode': value,
      if (instance.errors case final value?) 'errors': value,
    };

Errors _$ErrorsFromJson(Map<String, dynamic> json) => Errors(
      fieldName: json['fieldName'] as String?,
      errorValues: (json['errorValues'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      exactValues: (json['exactValues'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ErrorsToJson(Errors instance) => <String, dynamic>{
      if (instance.fieldName case final value?) 'fieldName': value,
      if (instance.errorValues case final value?) 'errorValues': value,
      if (instance.exactValues case final value?) 'exactValues': value,
    };
