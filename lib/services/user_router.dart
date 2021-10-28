import 'api_base_router.dart';

class UserRouter extends ApiRouter {
  UserRouter.getListUser(int delay) : super(path: 'users', params: {'delay': delay}, method: Method.Get);
}