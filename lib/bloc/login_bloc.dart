import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(const LoginState()) {
    on<EmailChanged>((event, emit) {
      bool isValid = event.email.isNotEmpty && state.password.isNotEmpty;
      emit(state.copyWith(
        email: event.email,
        isEmailChanged: true,
        isValid: isValid,
      ));
    });

    on<PasswordChanged>((event, emit) {
      bool isValid = state.email.isNotEmpty && event.password.isNotEmpty;
      emit(state.copyWith(
        password: event.password,
        isPasswordChanged: true,
        isValid: isValid,
      ));
    });

    on<LoginSubmitted>((event, emit) async {
      if (!state.isValid) return;

      emit(state.copyWith(status: LoginStatus.loading));

      try {
        await authRepository.logIn();
        emit(state.copyWith(status: LoginStatus.success));
      } catch (_) {
        emit(state.copyWith(status: LoginStatus.failure));
      }
    });
  }
}
