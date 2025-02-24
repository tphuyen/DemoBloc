import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final String input1;
  final String input2;
  final bool isInput1Changed;
  final bool isInput2Changed;
  final bool isValid;
  final LoginStatus status;

  LoginState({
    required this.input1,
    required this.input2,
    required this.isInput1Changed,
    required this.isInput2Changed,
    required this.isValid,
    required this.status,
  });

  factory LoginState.initial() {
    return LoginState(
      input1: '',
      input2: '',
      isInput1Changed: false,
      isInput2Changed: false,
      isValid: false,
      status: LoginStatus.initial,
    );
  }

  LoginState copyWith({
    String? input1,
    String? input2,
    bool? isInput1Changed,
    bool? isInput2Changed,
    bool? isValid,
    LoginStatus? status,
  }) {
    return LoginState(
      input1: input1 ?? this.input1,
      input2: input2 ?? this.input2,
      isInput1Changed: isInput1Changed ?? this.isInput1Changed,
      isInput2Changed: isInput2Changed ?? this.isInput2Changed,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [input1, input2, isInput1Changed, isInput2Changed, isValid, status];
}
