import 'package:ordering_system_client_app/configurations.dart';

enum ApiMethod { email, uid }

class ApiConfig {
  static const String login = '/login';
  static const String users = '/users';
  static const String otp = '/otp';
  static const String stores = '/stores';
  static const String menus = '/menus';
  static const String resetPassword = '/reset-password';
  static const String create = '/create';
  static const String verify = '/verify';
  static const String orderTickets = '/order-tickets';
  static const String fcmTokens = '/fcm-tokens';

  static String storesWithId(String storeId) {
    return '$stores/$storeId';
  }

  static String usersWithId(String userId) {
    return '$users/$userId';
  }

  static String languageParam(int languageId) {
    return 'language=$languageId';
  }

  static String userTypeParam({int userType = defaultUserType}) {
    return 'userType=$userType';
  }

  static String userIdParam(String userId) {
    return 'userId=$userId';
  }

  static String emailParam(String email) {
    return 'email=$email';
  }

  static String uidParam(String uid) {
    return 'uid=$uid';
  }

  static String methodParam(ApiMethod method) {
    late String methodStr = '';

    switch (method) {
      case ApiMethod.uid:
        methodStr = 'uid';
        break;
      case ApiMethod.email:
        methodStr = 'email';
        break;
    }

    return 'method=$methodStr';
  }
}
