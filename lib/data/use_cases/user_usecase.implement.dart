import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/register/register_request.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/repositories/user.repositories.dart';
import 'package:base_app/domain/use_cases/user_usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserUseCase)
class UserUseCaseImpl extends UserUseCase {
  final UserRepository _userRepository;

  UserUseCaseImpl() : _userRepository = dI<UserRepository>();

  @override
  Future<bool> changePassword(
      {required String newPassword, required String currentPassword}) async {
    final bool result = await _userRepository.changePassword(newPassword, currentPassword);
    return result;
  }

  @override
  Future<User> getUserInfo() async {
    final user = await _userRepository.getUserInfo();
    return user;
  }

  @override
  Future<List<User>> getUserByRole({required String role}) async {
    final List<User> users = await _userRepository.getUserByRole(role: role);
    return users;
  }

  @override
  Future<int> forgotPassword({required String email}) async {
    return await _userRepository.forgotPassword(email: email);
  }

  @override
  Future<int> register({required RegisterRequest registerRequest}) async {
    return await _userRepository.register(registerRequest: registerRequest);
  }

  @override
  Future<int> deleteAccount() async {
    return await _userRepository.deleteAccount();
  }
}
