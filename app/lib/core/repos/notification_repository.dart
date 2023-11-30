import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ordering_system_client_app/core/models/core/api_config.dart';
import 'package:ordering_system_client_app/core/models/core/failure.dart';
import 'package:ordering_system_client_app/core/repos/i_notification_repository.dart';
import 'package:ordering_system_client_app/http.dart';

// dio status code 4xx 會自動到catch
class NotificationRepository implements INotificationRepository {
  NotificationRepository();

  @override
  Future<Option<Failure>> createFcmToken({
    required String userId,
    required String token,
  }) async {
    try {
      const path = ApiConfig.fcmTokens;

      await dio.post(
        path,
        data: {"userId": userId, "token": token},
      );

      return none();
    } catch (e) {
      if (e is DioException && e.response != null) {
        logger.w(e.response?.data);
        return some(Failure.serverError());
      } else {
        logger.e(e);
        return some(Failure.unexpected());
      }
    }
  }

  @override
  Future<Option<Failure>> deleteFcmToken({
    required String userId,
    required String token,
  }) async {
    try {
      const String path = ApiConfig.fcmTokens;

      await dio.delete(
        path,
        data: {"userId": userId, "token": token},
      );

      return none();
    } catch (e) {
      if (e is DioException && e.response != null) {
        logger.w(e.response?.data);
        return some(Failure.serverError());
      } else {
        logger.e(e);
        return some(Failure.unexpected());
      }
    }
  }
}
