import 'package:dartz/dartz.dart';
import 'package:ordering_system_client_app/core/models/core/failure.dart';

abstract class INotificationRepository {
  Future<Option<Failure>> createFcmToken({
    required String userId,
    required String token,
  });
  Future<Option<Failure>> deleteFcmToken({
    required String userId,
    required String token,
  });
}
