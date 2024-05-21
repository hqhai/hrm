// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_configs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
      env: json['ENV'] as String? ?? '',
      baseUrl: json['BASE_URL'] as String? ?? '',
      baseAuthUrl: json['BASE_AUTH_URL'] as String? ?? '',
      baseUserUrl: json['BASE_USER_URL'] as String? ?? '',
      baseRequestUrl: json['BASE_REQUEST_URL'] as String? ?? '',
      baseURLFile: json['BASE_STORAGE_URL'] as String? ?? '',
      baseSystemUrl: json['BASE_SYSTEM_URL'] as String? ?? '',
      baseSystemGatewayUrl: json['BASE_SYSTEM_GATEWAY_URL'] as String? ?? '',
    );

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
      'BASE_SYSTEM_URL': instance.baseSystemUrl,
      'BASE_STORAGE_URL': instance.baseURLFile,
      'BASE_AUTH_URL': instance.baseAuthUrl,
      'BASE_USER_URL': instance.baseUserUrl,
      'BASE_REQUEST_URL': instance.baseRequestUrl,
      'BASE_SYSTEM_GATEWAY_URL': instance.baseSystemGatewayUrl,
      'BASE_URL': instance.baseUrl,
      'ENV': instance.env,
    };
