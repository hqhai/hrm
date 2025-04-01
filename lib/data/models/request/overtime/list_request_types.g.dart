// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_request_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListRequestTypes _$ListRequestTypesFromJson(Map<String, dynamic> json) =>
    ListRequestTypes(
      listRequestTypes: (json['listRequestTypes'] as List<dynamic>?)
              ?.map((e) => CreateOverTimeConfigRequest.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ListRequestTypesToJson(ListRequestTypes instance) =>
    <String, dynamic>{
      if (instance.listRequestTypes case final value?)
        'listRequestTypes': value,
    };
