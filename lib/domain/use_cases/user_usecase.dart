import 'package:base_app/data/models/register/register_request.dart';
import 'package:base_app/data/models/user/profile/update_profile_request.dart';
import 'package:base_app/data/models/user/search/search_user_by_name_response.dart';
import 'package:base_app/domain/entities/user.dart';

abstract class UserUseCase {
  Future<bool> changePassword({required String newPassword, required String currentPassword});

  Future<User> getUserInfo();

  Future<List<User>> getUserByRole({required String role});

  Future<String> forgotPassword({required String email});

  Future<int> register({required RegisterRequest registerRequest});

  Future<int> deleteAccount();

  Future<int> updateProfile({required UpdateProfileRequest updateProfileRequest});

  Future<SearchUserByNameResponse> getUserByFullName({required String fullName, int? page});
}
