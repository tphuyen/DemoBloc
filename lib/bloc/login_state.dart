import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isEmailChanged;
  final bool isPasswordChanged;
  final bool isValid;
  final LoginStatus status;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isEmailChanged = false,
    this.isPasswordChanged= false,
    this.isValid = false,
    this.status = LoginStatus.initial,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isEmailChanged,
    bool? isPasswordChanged,
    bool? isValid,
    LoginStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailChanged: isEmailChanged ?? this.isEmailChanged,
      isPasswordChanged: isPasswordChanged ?? this.isPasswordChanged,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, password, isEmailChanged, isPasswordChanged, isValid, status];
}