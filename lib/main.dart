import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_call_api/cubit/user_cubit.dart';
import 'package:flutter_call_api/pages/users_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Users'),
        ),
        body: BlocProvider(
            create: (_) => UserCubit(),
            child: UsersPage()
        ),
      ),
    );
  }
}