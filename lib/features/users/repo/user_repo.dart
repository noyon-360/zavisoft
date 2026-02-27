import 'package:zavisoft_task/core/api/network_stream.dart';

import '../models/user_model.dart';

abstract class UserRepo {
  NetworkStream<UserModel> getUser({bool forceRefresh = false});
}