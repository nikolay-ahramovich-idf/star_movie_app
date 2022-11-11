import 'package:domain/entities/user_entity.dart';
import 'package:domain/exceptions/validation_exception.dart';
import 'package:domain/repositories/remote_store_repository.dart';
import 'package:domain/usecases/user_is_registered_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteStoreRepository extends Mock implements RemoteStoreRepository {}

class MockUserEntity extends Mock implements UserEntity {}

void main() {
  final mockRemoteStoreRepository = MockRemoteStoreRepository();

  final userIsRegisteredUseCase = UserIsRegisteredUseCase(
    mockRemoteStoreRepository,
  );

  setUpAll(
    () => registerFallbackValue(MockUserEntity()),
  );

  test('usecase completes without exception if user is registred', () {
    when(() => mockRemoteStoreRepository.checkUserExists(any()))
        .thenAnswer((_) async => true);

    expect(
      userIsRegisteredUseCase(MockUserEntity()),
      isA<Future<void>>(),
    );
  });

  test('usecase throws exception if user is not registered', () {
    when(() => mockRemoteStoreRepository.checkUserExists(any()))
        .thenAnswer((_) async => false);

    expect(
      userIsRegisteredUseCase(MockUserEntity()),
      throwsA(isA<ValidationException>()),
    );
  });
}
