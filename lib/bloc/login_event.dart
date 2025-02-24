import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInputChanged extends LoginEvent {
  final String input1;
  final String input2;
  final bool isInput1Changed;
  final bool isInput2Changed;

  LoginInputChanged({
    required this.input1,
    required this.input2,
    required this.isInput1Changed,
    required this.isInput2Changed,
  });

  @override
  List<Object> get props => [input1, input2, isInput1Changed, isInput2Changed];
}

class LoginSubmitted extends LoginEvent {}
