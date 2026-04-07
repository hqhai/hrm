import 'package:base_app/domain/models/user/register_request.dart';
import 'package:base_app/domain/models/user/update_profile_request.dart';
import 'package:base_app/domain/models/user/search_user_by_name_response.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/repositories/user.repositories.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class UserUseCase {
  UserUseCase(this._userRepository);

  final UserRepository _userRepository;

  Future<bool> changePassword({required String newPassword, required String currentPassword}) async {
    final result = await _userRepository.changePassword(newPassword, currentPassword);
    return result ?? false;
  }

  Future<User> getUserInfo() async {
    final user = await _userRepository.getUserInfo();
    return user ?? const User();
  }

  Future<List<User>> getUserByRole({required String role}) async {
    final List<User>? users = await _userRepository.getUserByRole(role: role);
    return users ?? [];
  }

  Future<String> forgotPassword({required String email}) async {
    final response = await _userRepository.forgotPassword(email: email);
    return response ?? '';
  }

  Future<int> register({required RegisterRequest registerRequest}) async {
    final response = await _userRepository.register(registerRequest: registerRequest);
    return response ?? 0;
  }

  Future<int> deleteAccount() async {
    final response = await _userRepository.deleteAccount();
    return response ?? 0;
  }

  Future<User> updateProfile({required UpdateProfileRequest updateProfileRequest}) async {
    final response = await _userRepository.updateProfile(updateProfileRequest: updateProfileRequest);
    return response ?? const User();
  }

  Future<SearchUserByNameResponse> getUserByFullName({required String fullName, int? page}) async {
    final response = await _userRepository.getUserByFullName(fullName: fullName, page: page);
    return response ?? const SearchUserByNameResponse();
  }

  Future<List<User>> getUserById({required List<String> id}) async {
    final response = await _userRepository.getUserById(id: id);
    return response ?? [];
  }
}
