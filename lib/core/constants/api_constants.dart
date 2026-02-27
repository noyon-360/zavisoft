class ApiConstants {
  /// [Base Configuration]
  static const String baseDomain = 'https://fakestoreapi.com';

  static const String baseUrl = baseDomain;

  /// Dynamically generated WebSocket URL based on baseDomain
  static String get webSocketUrl {
    if (baseDomain.startsWith('https://')) {
      return baseDomain.replaceFirst('https://', 'wss://');
    } else if (baseDomain.startsWith('http://')) {
      return baseDomain.replaceFirst('http://', 'ws://');
    }
    // Fallback for unexpected cases (e.g., no scheme)
    return 'ws://$baseDomain';
  }

  /// [Headers]
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> authHeaders(String token) => {
    ...defaultHeaders,
    'Authorization': 'Bearer $token',
  };

  static Map<String, String> get multipartHeaders => {
    'Accept': 'application/json',
    // Content-Type will be set automatically for multipart
  };

  /// [Endpoint Groups
  static AuthEndpoints get auth => AuthEndpoints();
  static UserEndpoints get user => UserEndpoints();
}

/// [Authentication Endpoints]
class AuthEndpoints {
  static const String _base = '${ApiConstants.baseUrl}/auth';

  final String login = '$_base/login';

  final String refreshToken = '$_base/refresh-token';

}

class UserEndpoints {
  static const String _base = '${ApiConstants.baseUrl}/users';
  final String users = _base;

  final String updatePersonalInfo = '$_base/update-profile';

  final String profile = '$_base/profile';
  final String deleteAccount = '$_base/delete-account';
}
