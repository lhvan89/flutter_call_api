import 'package:flutter_call_api/cubit/base_cubit.dart';
import 'package:flutter_call_api/services/user_router.dart';
import 'package:flutter_call_api/model/user_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_call_api/services/api_request.dart';

class UserCubit extends BaseCubit {

  @override
  void initCubit() {
    super.initCubit();
    getListUser();
  }

  BehaviorSubject<List<UserModel>?> userDataStream = BehaviorSubject();

  void getListUser() async {
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