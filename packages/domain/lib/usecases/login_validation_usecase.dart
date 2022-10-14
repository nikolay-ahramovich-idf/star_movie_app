import 'package:domain/entities/user_entity.dart';
import 'package:domain/entities/validation_entity.dart';
import 'package:domain/services/validation_service.dart';
import 'package:domain/usecases/usecase.dart';

class LoginValidationUseCase
    implements UseCaseParams<UserEntity, ValidationEntity> {
  final ValidationService _validationService;

  LoginValidationUseCase(this._validationService);

  @override
  ValidationEntity call(UserEntity params) {
    final loginIsCorrect = _validationService.validateLogin(params.login);
    
    final passwordIsCorrect =
        _validationService.validatePassword(params.password);

    return ValidationEntity(
      loginIsCorrect,
      passwordIsCorrect,
    );
  }
}
