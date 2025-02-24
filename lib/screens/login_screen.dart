import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/repository/auth_repository.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(AuthRepository()),
      child: LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomeScreen()));
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            if (state.status == LoginStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) =>
                    previous.email != current.email ||
                        previous.isEmailChanged != current.isEmailChanged,
                    builder: (context, state) {
                      return TextField(
                        onChanged: (value) {
                          context.read<LoginBloc>().add(EmailChanged(value));
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: state.isEmailChanged && state.email.isEmpty
                                ? Colors.red
                                : Colors.black,
                          ),
                          errorText: state.isEmailChanged && state.email.isEmpty
                              ? 'Required'
                              : null,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) =>
                    previous.password != current.password ||
                        previous.isPasswordChanged != current.isPasswordChanged,
                    builder: (context, state) {
                      return TextField(
                        obscureText: true,
                        onChanged: (value) {
                          context.read<LoginBloc>().add(PasswordChanged(value));
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: state.isPasswordChanged && state.password.isEmpty
                                ? Colors.red
                                : Colors.black,
                          ),
                          errorText: state.isPasswordChanged && state.password.isEmpty
                              ? 'Required'
                              : null,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) => previous.isValid != current.isValid,
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state.isValid
                            ? () {
                          context.read<LoginBloc>().add(LoginSubmitted());
                        }
                            : null,
                        child: const Text('Login'),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
