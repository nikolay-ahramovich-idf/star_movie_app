import 'package:data/repositories/auth_repository_impl.dart';
import 'package:domain/entities/user_entity.dart';
import 'package:domain/exceptions/auth_failure_exception.dart';
import 'package:domain/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  const mockLogin = 'login';
  const mockPassword = 'password';

  late MockAuthService mockAuthService = MockAuthService();
  late AuthRepositoryImpl authRepository = AuthRepositoryImpl(
    mockAuthService,
    mockAuthService,
  );

  const user = UserEntity(
    login: mockLogin,
    password: mockPassword,
  );

  group('will return object with credentials if auth is success', () {
    setUpAll(() {
      when(() => mockAuthService.login()).thenAnswer((_) async => {
            'email': mockLogin,
            'id': mockPassword,
          });
    });

    test('facebook auth', () async {
      expect(
        await authRepository.authWithFacebook(),
        user,
      );
    });

    test('google auth', () async {
      expect(
        await authRepository.authWithGoogle(),
        user,
      );
    });
  });

  group('will complete with exception if auth is failure', () {
    setUpAll(() {
      when(() => mockAuthService.login()).thenThrow(AuthFailureException());
    });

    test('facebook auth', () {
      expect(
        authRepository.authWithFacebook(),
        throwsA(isA<AuthFailureException>()),
      );
    });

    test('google auth', () {
      expect(
        authRepository.authWithFacebook(),
        throwsA(isA<AuthFailureException>()),
      );
    });
  });
}
