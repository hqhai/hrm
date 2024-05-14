import 'package:base_app/data/models/register/register_request.dart';
import 'package:base_app/domain/entities/user.dart';

abstract class UserUseCase {
  Future<bool> changePassword({required String newPassword, required String currentPassword});

  Future<User> getUserInfo();

  Future<List<User>> getUserByRole({required String role});

  Future<int> forgotPassword({required String email});

  Future<int> register({required RegisterRequest registerRequest});
}
