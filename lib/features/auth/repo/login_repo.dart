import 'package:zavisoft_task/core/api/network_result.dart';
import 'package:zavisoft_task/features/auth/models/login_request_model.dart';
import 'package:zavisoft_task/features/auth/models/login_response_model.dart';

abstract class LoginRepo {
  NetworkResult<LoginResponseModel> login(LoginRequestModel request);
}
