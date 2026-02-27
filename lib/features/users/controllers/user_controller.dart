import 'package:get/get.dart';
import 'package:zavisoft_task/core/api/network_stream.dart';
import 'package:zavisoft_task/features/users/repo/user_repo.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  final _userRepo = Get.find<UserRepo>();

  @override
  void onInit() {
    super.onInit();
    getUser(forceRefresh: true);
  }

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxBool _forceRefresh = false.obs;
  bool get forceRefresh => _forceRefresh.value;

  final Rxn<UserModel> _user = Rxn<UserModel>();
  UserModel? get user => _user.value;

  Future<void> getUser({bool forceRefresh = false}) async {
    _forceRefresh.value = forceRefresh;
    _isLoading.value = true;
    await _userRepo
        .getUser(forceRefresh: forceRefresh)
        .bind(rx: _user, loading: _isLoading);
    _isLoading.value = false;
  }
}
