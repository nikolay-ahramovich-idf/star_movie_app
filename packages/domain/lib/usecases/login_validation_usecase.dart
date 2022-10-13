import 'package:domain/entities/user_entity.dart';
import 'package:domain/services/validation_service.dart';
import 'package:domain/usecases/usecase.dart';

class LoginValidationUseCase implements UseCaseParams<UserEntity, bool> {
  final ValidationService _validationService;

  LoginValidationUseCase(this._validationService);

  @override
  bool call(UserEntity params) {
    return _validationService.validateLogin(params.login) &&
        _validationService.validatePassword(params.password);
  }
}
