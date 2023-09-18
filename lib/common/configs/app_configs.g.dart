// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_configs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
      env: json['ENV'] as String? ?? '',
      baseUrl: json['BASE_URL'] as String? ?? '',
      baseApiUrl: json['BASE_API_URL'] as String? ?? '',
    );

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
      'BASE_API_URL': instance.baseApiUrl,
      'BASE_URL': instance.baseUrl,
      'ENV': instance.env,
    };
