import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/register/register_request.dart';
import 'package:base_app/data/models/user/profile/update_profile_request.dart';
import 'package:base_app/data/models/user/search/search_user_by_name_response.dart';
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
  Future<String> forgotPassword({required String email}) async {
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

  @override
  Future<User> updateProfile({required UpdateProfileRequest updateProfileRequest}) async {
    return await _userRepository.updateProfile(updateProfileRequest: updateProfileRequest);
  }

  @override
  Future<SearchUserByNameResponse> getUserByFullName({required String fullName, int? page}) async {
    return await _userRepository.getUserByFullName(fullName: fullName, page: page);
  }

  @override
  Future<List<User>> getUserById({required List<String> id}) async {
    return await _userRepository.getUserById(id: id);
  }

}
