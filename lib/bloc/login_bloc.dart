import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginState.initial()) {
    on<LoginInputChanged>((event, emit) {
      bool isValid = event.input1.isNotEmpty && event.input2.isNotEmpty;
      emit(state.copyWith(
        input1: event.input1,
        input2: event.input2,
        isInput1Changed: event.isInput1Changed,
        isInput2Changed: event.isInput2Changed,
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
