import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_call_api/cubit/user_cubit.dart';
import '../model/user_model.dart';

class UsersPage extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, List<UserModel>>(
        builder: (context, listUser) {
          context.read<UserCubit>().getListUser();
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                UserModel user = listUser[index];
                return UserWidget(
                  first_name: user.firstName,
                  last_name: user.lastName,
                  email: user.email,
                  avatar: user.avatar,
                );
              },
            itemCount: listUser.length,
          );
        }
    );
  }
}

class UserWidget extends StatelessWidget {
  String? first_name;
  String? last_name;
  String? email;
  String? avatar;

  UserWidget({this.first_name, this.last_name, this.email, this.avatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 1),
            )
          ]),
      height: 80,
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 8),
              child: CircleAvatar(
                  backgroundImage: NetworkImage('$avatar'), radius: 30)),
          SizedBox(width: 16),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$first_name $last_name',
                    style:
                        TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
                SizedBox(height: 5),
                Text('$email', style: TextStyle(fontSize: 17))
              ],
            ),
          ),
        ],
      ),
    );
  }
}