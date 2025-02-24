import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/repository/auth_repository.dart';
import 'package:login_bloc/screens/login_screen.dart';

import 'bloc/login_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => LoginBloc(AuthRepository()),
        child: LoginScreen(),
      ),
    );
  }
}