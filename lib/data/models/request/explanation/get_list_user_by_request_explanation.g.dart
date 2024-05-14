// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_user_by_request_explanation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListUserByRequestExplanationRequest
    _$GetListUserByRequestExplanationRequestFromJson(
            Map<String, dynamic> json) =>
        GetListUserByRequestExplanationRequest(
          endDate: json['endDate'] as String? ?? '',
          startDate: json['startDate'] as String? ?? '',
        );

Map<String, dynamic> _$GetListUserByRequestExplanationRequestToJson(
        GetListUserByRequestExplanationRequest instance) =>
    <String, dynamic>{
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
