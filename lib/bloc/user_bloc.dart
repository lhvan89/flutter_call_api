import 'dart:async';
import 'dart:convert';
import 'package:flutter_call_api/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserBloc {
  final userData = StreamController<List<UserModel>>();

  getListUser() async {
    http.Response response =
        await http.get(Uri.parse('https://reqres.in/api/users?delay=3'));
    if (response.statusCode == 200) {
      var decodeData = json.decode(response.body);
      List<UserModel> listUser = List<UserModel>.from(
          decodeData['data'].map((model) => UserModel.fromJson(model)));
      userData.sink.add(listUser);
    }
  }
}
