import 'package:get/get.dart';

class SessionService extends GetxService {
  final accessToken = "".obs;
  final refreshToken = "".obs;
  final userId = "".obs;
  final role = "".obs;

  bool get hasToken => accessToken.value.isNotEmpty;
  bool get hasRefreshToken => refreshToken.value.isNotEmpty;
  bool get hasUserId => userId.value.isNotEmpty;
  bool get hasRole => role.value.isNotEmpty;

  void clearToken() {
    accessToken.value = "";
    role.value = "";
  }
}
