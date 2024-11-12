import 'package:TeaShopApp/src/features/auth/data/auth_repo.dart';
import 'package:TeaShopApp/src/features/auth/data/models/login_model/login_model.dart';
import 'package:TeaShopApp/src/features/auth/data/models/regist_model/registration_model.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  final AuthRepo _authRepo;

  AuthService(
    this._authRepo,
  );

  final _authState = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get authState => _authState.stream;

  Future<bool> login(LoginModel loginModel) async {
    return await _authRepo.login(loginModel);
  }

  Future<void> authDone() async {
    _authState.value = true;
    await setProfileLogging(true);
  }

  Future<void> checkAuthState() async {
    _authState.value = await getProfileLogging();
  }

  Future<void> logout() async {
    _authState.value = false;
    await setProfileLogging(false);
  }

  Future<String> registration(RegistrationModel registrationModel) async {
    final token = await _authRepo.registration(registrationModel);

    return token;
  }

  Future<void> resetPass(String email) async {
    await _authRepo.resetPass(email);
  }

  Future<String> verifyProfile(String token) async {
    return await _authRepo.verifyProfile(token);
  }

  Future<void> setProfileLogging(bool value) async {
    await _authRepo.setProfileLogging(value);
  }

  Future<bool> getProfileLogging() async {
    return await _authRepo.getProfileLogging();
  }
}
