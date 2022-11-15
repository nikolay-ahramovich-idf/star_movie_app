import 'package:domain/entities/user_entity.dart';
import 'package:domain/exceptions/validation_exception.dart';
import 'package:domain/usecases/facebook_auth_usecase.dart';
import 'package:domain/usecases/google_auth_usecase.dart';
import 'package:domain/usecases/log_analytics_event_usecase.dart';
import 'package:domain/usecases/login_validation_usecase.dart';
import 'package:domain/usecases/save_credentials_usecase.dart';
import 'package:domain/usecases/user_is_registered_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:presentation/navigation/app_navigator.dart';
import 'package:presentation/screens/login/login_bloc.dart';

class MockAppNavigator extends Mock implements AppNavigator {}

class MockLogAnalyticsEventUseCase extends Mock
    implements LogAnalyticsEventUseCase {}

class MockUserIsRegisteredUseCase extends Mock
    implements UserIsRegisteredUseCase {}

class MockFacebookAuthUseCase extends Mock implements FacebookAuthUseCase {}

class MockGoogleAuthUseCase extends Mock implements GoogleAuthUseCase {}

class MockSaveCredentialsUseCase extends Mock
    implements SaveCredentialsUseCase {}

class MockLoginValidationUseCase extends Mock
    implements LoginValidationUseCase {}

class MockUserEntity extends Mock implements UserEntity {}

class MockGlobalKey extends Mock implements GlobalKey<FormState> {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerSingleton<AppNavigator>(MockAppNavigator());

  final mockLogAnalyticsEventUseCase = MockLogAnalyticsEventUseCase();

  GetIt.I.registerSingleton<LogAnalyticsEventUseCase>(
    mockLogAnalyticsEventUseCase,
  );

  final mockUserIsRegisteredUseCase = MockUserIsRegisteredUseCase();
  final mockFacebookAuthUseCase = MockFacebookAuthUseCase();
  final mockGoogleAuthUseCase = MockGoogleAuthUseCase();
  final mockSaveCredentialsUseCase = MockSaveCredentialsUseCase();
  final mockLoginValidationUseCase = MockLoginValidationUseCase();

  final loginBloc = LoginBloc(
    mockUserIsRegisteredUseCase,
    mockFacebookAuthUseCase,
    mockGoogleAuthUseCase,
    mockSaveCredentialsUseCase,
    mockLoginValidationUseCase,
  );

  setUpAll(() {
    registerFallbackValue(MockUserEntity());

    when(() => mockLogAnalyticsEventUseCase(any()))
        .thenAnswer((_) => Future<void>.value());

    when(() => mockSaveCredentialsUseCase(any()))
        .thenAnswer((_) => Future<void>.value());
  });

  group('auth flow success cases', () {
    setUpAll(() {
      when(() => mockUserIsRegisteredUseCase(any()))
          .thenAnswer((_) => Future<void>.value());
    });

    test(
      'onLogin has to be traced by analytics',
      () {
        loginBloc.onLogin();

        verify(() => mockLogAnalyticsEventUseCase(any())).called(1);
      },
    );

    test(
      'onLogin has not to change validation status if auth flow is success',
      () {
        loginBloc.onLogin();

        final actualLoginValidationStatus =
            loginBloc.state.loginValidationStatus;
        final actualPasswordValidationStatus =
            loginBloc.state.passwordValidationStatus;

        expect(
          actualLoginValidationStatus,
          null,
        );
        expect(
          actualPasswordValidationStatus,
          null,
        );
      },
    );
  });

  group('auth flow failure cases', () {
    final mockGlobalKey = MockGlobalKey();

    setUpAll(() {
      when(() => mockGlobalKey.currentState).thenReturn(null);
    });

    test(
      'onLogin has to change validation status if validation is failed',
      () {
        when(() => mockLoginValidationUseCase(any())).thenThrow(
          ValidationException(
            ValidationExceptionStatus.empty,
            ValidationExceptionStatus.regExp,
          ),
        );

        loginBloc.onLogin();

        final actualLoginValidationStatus =
            loginBloc.state.loginValidationStatus;
        final actualPasswordValidationStatus =
            loginBloc.state.passwordValidationStatus;

        expect(
          actualLoginValidationStatus,
          ValidationExceptionStatus.empty,
        );
        expect(
          actualPasswordValidationStatus,
          ValidationExceptionStatus.regExp,
        );
      },
    );

    test(
      'onLogin has to change validation status if auth is failed',
      () async {
        when(() => mockLoginValidationUseCase(any()))
            .thenAnswer((_) => Future<void>.value());

        when(() => mockUserIsRegisteredUseCase(any())).thenThrow(
          ValidationException(
            ValidationExceptionStatus.authFailed,
            ValidationExceptionStatus.authFailed,
          ),
        );

        await loginBloc.onLogin();

        final actualLoginValidationStatus =
            loginBloc.state.loginValidationStatus;
        final actualPasswordValidationStatus =
            loginBloc.state.passwordValidationStatus;

        expect(
          actualLoginValidationStatus,
          ValidationExceptionStatus.authFailed,
        );
        expect(
          actualPasswordValidationStatus,
          ValidationExceptionStatus.authFailed,
        );
      },
    );
  });
}
