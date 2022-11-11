import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String login;
  final String password;

  const UserEntity({
    required this.login,
    required this.password,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        login: json['login'],
        password: json['password'],
      );

  factory UserEntity.fromAuthJson(Map<String, dynamic> json) => UserEntity(
        login: json['email'],
        password: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'login': login,
        'password': password,
      };

  @override
  List<Object?> get props => [
        login,
        password,
      ];
}
