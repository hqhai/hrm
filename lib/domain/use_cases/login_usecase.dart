import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/constants/key_constance.dart';
import 'package:base_app/common/storage/local_storage.dart';
import 'package:base_app/domain/models/auth/login_response.dart';
import 'package:base_app/domain/repositories/auth.repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LoginUseCase {
  LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<LoginResponse?> login(
      {required String username, required String password}) async {
    final loginResponse = await _authRepository.login(username, password);
    AppLocalStorage.saveData(DataKey.token, loginResponse?.accessToken);
    AppLocalStorage.saveData(DataKey.fullName, loginResponse?.fullName);
    AppLocalStorage.saveData(DataKey.passwordBiometric, password);
    AppLocalStorage.saveListData(DataKey.roles, loginResponse?.roles);
    AppConfig.setToken(loginResponse?.accessToken ?? "");
    return loginResponse;
  }

  Future<bool> checkAccountBiometric(
      {required String username, required String password}) async {
    return await _authRepository.checkAccountBiometric(
        username: username, password: password);
  }
}
