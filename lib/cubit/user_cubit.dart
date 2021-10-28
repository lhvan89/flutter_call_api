import 'dart:convert';
import 'package:flutter_call_api/services/user_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_call_api/model/user_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_call_api/services/api_request.dart';

class UserCubit extends Cubit<bool> {
  UserCubit(): super(false) {
    getListUser();
  }

  BehaviorSubject<List<UserModel>?> userDataStream = BehaviorSubject();

  void getListUser() async {
    // var uri = Uri.parse('https://reqres.in/api/users?delay=3');
    // http.Response response = await http.get(uri);
    // if (response.statusCode == 200) {
    //   var decodeData = json.decode(response.body);
    //   List<UserModel> listUser = List<UserModel>.from(decodeData['data'].map((model) => UserModel.fromJson(model)));
    //   userDataStream.sink.add(listUser);
    // }
    final response = await ApiClient.instance.requestArray(router: UserRouter.getListUser(3), target: UserModel());
    response.onCompleted(success: (datas) {
      userDataStream.sink.add(datas?.cast());
    }, error: (code, msg) {
      print('error: $msg');
    });

  }

  @override
  Future<void> close() {
    // TODO: implement close
    print('cubit close');
    userDataStream.close();
    return super.close();
  }
}