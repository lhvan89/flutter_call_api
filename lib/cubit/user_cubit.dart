import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_call_api/model/user_model.dart';

class UserCubit extends Cubit<List<UserModel>> {
  UserCubit(): super([]);

  void getListUser() async {
    var uri = Uri.parse('https://reqres.in/api/users?delay=3');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var decodeData = json.decode(response.body);
      List<UserModel> listUser = List<UserModel>.from(decodeData['data'].map((model) => UserModel.fromJson(model)));
      emit(listUser);
    }
  }
}