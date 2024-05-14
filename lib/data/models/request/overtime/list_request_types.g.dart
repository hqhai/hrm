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

Map<String, dynamic> _$ListRequestTypesToJson(ListRequestTypes instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('listRequestTypes', instance.listRequestTypes);
  return val;
}
