import 'package:zavisoft_task/core/api/api_client.dart';
import 'package:zavisoft_task/core/api/network_stream.dart';
import 'package:zavisoft_task/core/constants/api_constants.dart';
import 'package:zavisoft_task/features/users/repo/user_repo.dart';

import '../models/user_model.dart';

class UserRepoImpl implements UserRepo {
  final ApiClient _apiClient;
  UserRepoImpl({required ApiClient apiClient}) : _apiClient = apiClient;
  @override
  NetworkStream<UserModel> getUser({bool forceRefresh = false}) {
    return _apiClient.getStream(
      endpoint: ApiConstants.user.user,
      cacheDuration: const Duration(days: 15),
      forceEmitRemote: forceRefresh,
      fromJsonT: (json) => UserModel.fromJson(json),
    );
  }
}
