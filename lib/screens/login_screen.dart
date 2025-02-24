import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.success) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
          }
        },
        builder: (context, state) {
          if (state.status == LoginStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    context.read<LoginBloc>().add(LoginInputChanged(
                      input1: value,
                      input2: state.input2,
                      isInput1Changed: true,
                      isInput2Changed: state.isInput2Changed,
                    ));
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: state.isInput1Changed && state.input1.isEmpty ? Colors.red : Colors.black,
                    ),
                    errorText: state.isInput1Changed && state.input1.isEmpty ? 'Email is required' : null,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    context.read<LoginBloc>().add(LoginInputChanged(
                      input1: state.input1,
                      input2: value,
                      isInput1Changed: state.isInput1Changed,
                      isInput2Changed: true,
                    ));
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: state.isInput2Changed && state.input2.isEmpty ? Colors.red : Colors.black,
                    ),
                    errorText: state.isInput2Changed && state.input2.isEmpty ? 'Password is required' : null,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: state.isValid
                      ? () {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                      : null,
                  child: Text('Login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
