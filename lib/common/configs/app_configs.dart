import 'package:json_annotation/json_annotation.dart';

part 'app_configs.g.dart';

AppConfig get appConfig => AppConfig.instance;
void setConfig(Map<String, String> env) {
  AppConfig._instance = AppConfig.fromJson(env);
}

@JsonSerializable()
class AppConfig {
  @JsonKey(name: 'BASE_SYSTEM_URL', defaultValue: '')
  final String baseSystemUrl;
  @JsonKey(name: 'BASE_STORAGE_URL', defaultValue: '')
  final String baseURLFile;
  @JsonKey(name: 'BASE_AUTH_URL', defaultValue: '')
  final String baseAuthUrl;
  @JsonKey(name: 'BASE_USER_URL', defaultValue: '')
  final String baseUserUrl;
  @JsonKey(name: 'BASE_REQUEST_URL', defaultValue: '')
  final String baseRequestUrl;
  @JsonKey(name: 'BASE_URL', defaultValue: '')
  final String baseUrl;
  @JsonKey(name: 'ENV', defaultValue: '')
  final String env;
  static String _token = '';
  static String get getToken => _token;

  AppConfig({this.env = '', this.baseUrl = '', this.baseAuthUrl = '', this.baseUserUrl = '', this.baseRequestUrl ='', this.baseURLFile ='', this.baseSystemUrl =''});

  static AppConfig? _instance;

  static AppConfig get instance => _instance ?? AppConfig.fromJson({});

  static void setToken(String token) {
    _token = token;
  }

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AppConfigToJson(this);
}
