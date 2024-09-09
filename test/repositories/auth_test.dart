import 'package:auth_template/models/network_response.dart';
import 'package:auth_template/repositories/auth.dart';
import 'package:test/test.dart';

void main() {
  AuthRepository _authRepository = AuthRepository();
  test('Register', () async {
    NetworkResponseModel response = await _authRepository.register(
      "Manan",
      "ardumanan@gmail.com",
      "Test1234@",
    );
    print(response.message);
    expect(response.success, true);
  });
  test('Login', () async {
    NetworkResponseModel response = await _authRepository.login(
      "ardumanan@gmail.com",
      "Test1234@",
    );
    print(response.message);
    expect(response.success, true);
  });
}
