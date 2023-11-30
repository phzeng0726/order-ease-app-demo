import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ordering_system_client_app/configurations.dart';
import 'package:ordering_system_client_app/core/models/core/api_config.dart';
import 'package:ordering_system_client_app/core/models/core/auth_failure.dart';
import 'package:ordering_system_client_app/core/models/dto/user_data_dto.dart';
import 'package:ordering_system_client_app/core/models/user_data.dart';
import 'package:ordering_system_client_app/core/repos/i_auth_repository.dart';
import 'package:ordering_system_client_app/http.dart';

// dio status code 4xx 會自動到catch
class AuthRepository implements IAuthRepository {
  AuthRepository();

  @override
  Future<Either<AuthFailure, String>> getUserIdByEmail({
    required String email,
  }) async {
    try {
      final params =
          '?${ApiConfig.userTypeParam()}&${ApiConfig.methodParam(ApiMethod.email)}&${ApiConfig.emailParam(email)}';
      final path = ApiConfig.users + ApiConfig.login + params;
      final response = await dio.get(path);

      if (response.data == '') {
        return left(AuthFailure.emailNotFoundInDatabase());
      }

      return right(response.data);
    } catch (e) {
      if (e is DioException && e.response != null) {
        logger.w(e.response?.data);
        return left(AuthFailure.serverError());
      } else {
        logger.e(e);
        return left(AuthFailure.unexpected());
      }
    }
  }

  Future<Either<AuthFailure, String>> getUserIdByUid({
    required String firebaseUid,
  }) async {
    try {
      final params =
          '?${ApiConfig.userTypeParam()}&${ApiConfig.methodParam(ApiMethod.uid)}&${ApiConfig.uidParam(firebaseUid)}';
      final path = ApiConfig.users + ApiConfig.login + params;
      final response = await dio.get(path);

      if (response.data == '') {
        return left(AuthFailure.uidNotFoundInDatabase());
      }

      return right(response.data);
    } catch (e) {
      if (e is DioException && e.response != null) {
        logger.w(e.response?.data);
        return left(AuthFailure.serverError());
      } else {
        logger.e(e);
        return left(AuthFailure.unexpected());
      }
    }
  }

  Future<Either<AuthFailure, UserData>> getUserInfoById({
    required String userId,
  }) async {
    try {
      final path = ApiConfig.usersWithId(userId);
      final response = await dio.get(path);

      final UserData user = UserDataDto.fromJson(response.data).toModel();

      return right(user);
    } catch (e) {
      if (e is DioException && e.response != null) {
        logger.w(e.response?.data);
        return left(AuthFailure.serverError());
      } else {
        logger.e(e);
        return left(AuthFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<AuthFailure, UserData>> getUserFromDatabase({
    required String firebaseUid,
  }) async {
    try {
      late UserData _user = UserData.empty();
      late AuthFailure _failure = AuthFailure.empty();

      final getUserIdResult = await getUserIdByUid(
        firebaseUid: firebaseUid,
      );

      await getUserIdResult.fold(
        (f) async => _failure = f,
        (userId) async {
          final getUserInfoResult = await getUserInfoById(
            userId: userId,
          );

          await getUserInfoResult.fold(
            (f) async => _failure = f,
            (user) async => _user = user,
          );
        },
      );

      if (_failure != AuthFailure.empty()) {
        print(_failure);
        return left(_failure);
      }

      return right(_user);
    } catch (e) {
      print(e);
      return left(AuthFailure.unexpected());
    }
  }

  @override
  Future<Option<AuthFailure>> createUser({
    required UserData user,
    required String password,
  }) async {
    try {
      const path = ApiConfig.users;
      final Map<String, dynamic> data = UserDataDto.fromModel(user).toJson();
      data['password'] = password;
      data['userType'] = defaultUserType;

      await dio.post(
        path,
        data: data,
      );

      return none();
    } catch (e) {
      if (e is DioException && e.response != null) {
        logger.w(e.response?.data);
        return some(AuthFailure.serverError());
      } else {
        logger.e(e);
        return some(AuthFailure.unexpected());
      }
    }
  }

  @override
  Future<Option<AuthFailure>> createOTP({
    required String email,
    required String token,
  }) async {
    try {
      const path = ApiConfig.otp + ApiConfig.create;

      await dio.post(
        path,
        data: {"token": token, "email": email},
      );

      return none();
    } catch (e) {
      if (e is DioException && e.response != null) {
        logger.w(e.response?.data);
        return some(AuthFailure.serverError());
      } else {
        logger.e(e);
        return some(AuthFailure.unexpected());
      }
    }
  }

  @override
  Future<Option<AuthFailure>> verifyOTP({
    required String token,
    required String otpCode,
  }) async {
    try {
      const path = ApiConfig.otp + ApiConfig.verify;

      await dio.post(
        path,
        data: {"token": token, "password": otpCode},
      );

      return none();
    } catch (e) {
      if (e is DioException && e.response != null) {
        logger.w(e.response?.data);
        return some(AuthFailure.serverError());
      } else {
        logger.e(e);
        return some(AuthFailure.unexpected());
      }
    }
  }

  @override
  Future<Option<AuthFailure>> resetPassword({
    required String userId,
    required String password,
  }) async {
    try {
      const path = ApiConfig.users + ApiConfig.resetPassword;

      await dio.post(
        path,
        data: {"userId": userId, "password": password},
      );

      return none();
    } catch (e) {
      if (e is DioException && e.response != null) {
        logger.w(e.response?.data);
        return some(AuthFailure.serverError());
      } else {
        logger.e(e);
        return some(AuthFailure.unexpected());
      }
    }
  }

  @override
  Future<Option<AuthFailure>> deleteUser({
    required String userId,
  }) async {
    try {
      final path = ApiConfig.usersWithId(userId);

      await dio.delete(
        path,
      );

      return none();
    } catch (e) {
      if (e is DioException && e.response != null) {
        logger.w(e.response?.data);
        return some(AuthFailure.serverError());
      } else {
        logger.e(e);
        return some(AuthFailure.unexpected());
      }
    }
  }
}
