import 'package:json_annotation/json_annotation.dart';

part 'app_configs.g.dart';

AppConfig get appConfig => AppConfig.instance;
void setConfig(Map<String, String> env) {
  AppConfig._instance = AppConfig.fromJson(env);
}

@JsonSerializable()
class AppConfig {
  @JsonKey(name: 'BASE_API_URL', defaultValue: '')
  final String baseApiUrl;
  @JsonKey(name: 'BASE_URL', defaultValue: '')
  final String baseUrl;
  @JsonKey(name: 'ENV', defaultValue: '')
  final String env;
  static String _token = '';
  static String get getToken => _token;

  AppConfig({this.env = '', this.baseUrl = '', this.baseApiUrl = ''});

  static AppConfig? _instance;

  static AppConfig get instance => _instance ?? AppConfig.fromJson({});

  static void setToken(String token) {
    _token = token;
  }

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AppConfigToJson(this);
}
