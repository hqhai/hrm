import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/constants/key_constance.dart';
import 'package:base_app/common/storage/local_storage.dart';
import 'package:base_app/data/models/response/login_response.dart';
import 'package:base_app/domain/repositories/auth.repository.dart';
import 'package:base_app/domain/use_cases/login_usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoginUseCase)
class LoginUseCaseImpl extends LoginUseCase {
  final AuthRepository _authRepository;
  LoginUseCaseImpl() : _authRepository = dI<AuthRepository>();
  @override
  Future<LoginResponse> login(
      {required String username, required String password}) async {
    final loginResponse = await _authRepository.login(username, password);
    AppLocalStorage.saveData(DataKey.token, loginResponse.accessToken);
    AppLocalStorage.saveData(DataKey.fullName, loginResponse.fullName);
    AppLocalStorage.saveListData(DataKey.roles, loginResponse.roles);
    AppConfig.setToken(loginResponse.accessToken);
    return loginResponse;
  }
}
