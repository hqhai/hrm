import 'package:encrypt_shared_preferences/provider.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants/shared_preference_constants.dart';
import '../../../common/mixins/log_mixin.dart';

@LazySingleton()
class AppPreferences with LogMixin {
  AppPreferences(this._sharedPreference, this._encryptedSharedPreferences);

  final SharedPreferences _sharedPreference;
  final EncryptedSharedPreferences _encryptedSharedPreferences;

  bool get isLoggedIn {
    final token = _encryptedSharedPreferences
        .getString(SharedPreferenceKeys.accessToken) ??
        '';

    return token.isNotEmpty;
  }

  String? get accessToken {
    return _encryptedSharedPreferences
        .getString(SharedPreferenceKeys.accessToken);
  }

  String? get refreshToken {
    return _encryptedSharedPreferences
        .getString(SharedPreferenceKeys.refreshToken);
  }

  Future<void> saveAccessToken(String token) async {
    await _encryptedSharedPreferences.setString(
      SharedPreferenceKeys.accessToken,
      token,
    );
  }

  Future<void> saveRefreshToken(String token) async {
    await _encryptedSharedPreferences.setString(
      SharedPreferenceKeys.refreshToken,
      token,
    );
  }

  Future<void> clearCurrentUserData() async {
    _encryptedSharedPreferences.clear();
    _sharedPreference.clear();
  }
}
