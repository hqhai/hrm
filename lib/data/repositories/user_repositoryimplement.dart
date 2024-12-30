import 'package:base_app/data/models/register/register_request.dart';
import 'package:base_app/data/models/request/change_password/change_password_request.dart';
import 'package:base_app/data/models/request/get_list_user_by_role/get_list_user_by_role.dart';
import 'package:base_app/data/models/user/forgot_password_request.dart';
import 'package:base_app/data/models/user/profile/update_profile_request.dart';
import 'package:base_app/data/models/user/search/search_user_by_name_request.dart';
import 'package:base_app/data/models/user/search/search_user_by_name_response.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/repositories/user.repositories.dart';
import 'package:injectable/injectable.dart';

import '../source/api/services/user_service.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final UserService _userService;

  UserRepositoryImpl(this._userService);

  @override
  Future<bool?> changePassword(String newPassword, String currentPassword) async {
    final response = await _userService.changPassword(ChangePasswordRequest(newPassword: newPassword, currentPassword: currentPassword));
    return response?.data;
  }

  @override
  Future<User?> getUserInfo() async {
    final response = await _userService.getUserInfo();
    return response?.data;
  }

  @override
  Future<List<User>?> getUserByRole({required String role}) async {
    final response = await _userService.getUserByRole(getListUserByRole: GetListUserByRole(role: role));
    return response?.result;
  }

  @override
  Future<String?> forgotPassword({required String email}) async {
    final response = await _userService.forgotPassword(forgotPasswordRequest: ForgotPasswordRequest(email: email));
    return response?.data;
  }

  @override
  Future<int?> register({required RegisterRequest registerRequest}) async {
    final response = await _userService.register(registerRequest: registerRequest);
    return response?.statusCode;
  }

  @override
  Future<int?> deleteAccount() async {
    final response = await _userService.deleteAccount();
    return response?.statusCode;
  }

  @override
  Future<User?> updateProfile({required UpdateProfileRequest updateProfileRequest}) async {
    final response = await _userService.updateProfile(updateProfileRequest: updateProfileRequest);
    return response?.data;
  }

  @override
  Future<SearchUserByNameResponse?> getUserByFullName({required String fullName, int? page}) async {
    final response = await _userService.getUserByFullName(searchUserByNameRequest: SearchUserByNameRequest(fullName: fullName, page: page ?? 0));
    final totalRecord = response?.meta?.pageInfo?.totalItems;
    final listUser = response?.meta?.items;

    return SearchUserByNameResponse(users: listUser ?? [], totalItems: totalRecord ?? 0);
  }

  @override
  Future<List<User>?> getUserById({required List<String> id}) async {
    final response = await _userService.getUserById(ids: id);
    return response?.result;
  }
}
