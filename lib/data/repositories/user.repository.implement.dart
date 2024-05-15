import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/register/register_request.dart';
import 'package:base_app/data/models/request/change_password/change_password_request.dart';
import 'package:base_app/data/models/request/get_list_user_by_role/get_list_user_by_role.dart';
import 'package:base_app/data/models/user/forgot_password_request.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/domain/repositories/user.repositories.dart';
import 'package:base_app/domain/services/user.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final UserService userService;

  UserRepositoryImpl() : userService = dI<UserService>();

  @override
  Future<bool> changePassword(String newPassword, String currentPassword) async {
    final bool result = await userService.changPassword(
        ChangePasswordRequest(newPassword: newPassword, currentPassword: currentPassword));
    return result;
  }

  @override
  Future<User> getUserInfo() async {
    final User user = await userService.getUserInfo();
    return user;
  }

  @override
  Future<List<User>> getUserByRole({required String role}) async {
    final List<User> users =
        await userService.getUserByRole(getListUserByRole: GetListUserByRole(role: role));
    return users;
  }

  @override
  Future<int> forgotPassword({required String email}) async {
    return await userService.forgotPassword(
        forgotPasswordRequest: ForgotPasswordRequest(email: email));
  }

  @override
  Future<int> register({required RegisterRequest registerRequest}) async {
    return await userService.register(registerRequest: registerRequest);
  }

  @override
  Future<int> deleteAccount() async {
    return await userService.deleteAccount();
  }
}
