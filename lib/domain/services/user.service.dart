import 'package:base_app/data/models/register/register_request.dart';
import 'package:base_app/data/models/request/change_password/change_password_request.dart';
import 'package:base_app/data/models/request/get_list_user_by_role/get_list_user_by_role.dart';
import 'package:base_app/data/models/user/forgot_password_request.dart';
import 'package:base_app/domain/entities/user.dart';

abstract class UserService {
  Future<User> getUserInfo();

  Future<bool> changPassword(ChangePasswordRequest changePasswordRequest);

  Future<List<User>> getUserByRole({required GetListUserByRole getListUserByRole});

  Future<int> forgotPassword({required ForgotPasswordRequest forgotPasswordRequest});

  Future<int> register({required RegisterRequest registerRequest});
}
