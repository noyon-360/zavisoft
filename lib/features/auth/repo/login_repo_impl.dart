import 'package:zavisoft_task/core/api/network_result.dart';
import 'package:zavisoft_task/features/auth/models/login_request_model.dart';
import 'package:zavisoft_task/features/auth/repo/login_repo.dart';

import '../../../core/api/api_client.dart';
import '../../../core/constants/api_constants.dart';
import '../models/login_response_model.dart';

class LoginRepoImpl implements LoginRepo {
  final ApiClient _apiClient;

  LoginRepoImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  NetworkResult<LoginResponseModel> login(LoginRequestModel request) {
    return _apiClient.post(
      endpoint: ApiConstants.auth.login,
      data: request.toJson(),
      fromJsonT: (json) => LoginResponseModel.fromJson(json),
    );
  }
}