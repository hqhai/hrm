import 'package:base_app/domain/repositories/auth.repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetInitAppUseCase {
  GetInitAppUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<bool> getInitApp() async {
    return _authRepository.isLoggedIn;
  }
}
