// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_list_status_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeListStatusRequest _$ChangeListStatusRequestFromJson(
        Map<String, dynamic> json) =>
    ChangeListStatusRequest(
      changeStatusRequestCommandModels:
          (json['changeStatusRequestCommandModels'] as List<dynamic>)
              .map((e) => ChangeStatusRequestCommandModels.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      enumRequestType: json['enumRequestType'] as String,
    );

Map<String, dynamic> _$ChangeListStatusRequestToJson(
        ChangeListStatusRequest instance) =>
    <String, dynamic>{
      'changeStatusRequestCommandModels':
          instance.changeStatusRequestCommandModels,
      'enumRequestType': instance.enumRequestType,
    };
