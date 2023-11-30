import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ordering_system_client_app/core/models/core/api_config.dart';
import 'package:ordering_system_client_app/core/models/core/failure.dart';
import 'package:ordering_system_client_app/core/models/dto/menu_data_dto.dart';
import 'package:ordering_system_client_app/core/models/dto/order_ticket_data_dto.dart';
import 'package:ordering_system_client_app/core/models/menu_data.dart';
import 'package:ordering_system_client_app/core/models/order_ticket_data.dart';
import 'package:ordering_system_client_app/core/repos/i_order_repository.dart';
import 'package:ordering_system_client_app/http.dart';

// dio status code 4xx 會自動到catch
class OrderRepository implements IOrderRepository {
  OrderRepository();

  @override
  Future<Either<Failure, MenuData>> getStoreMenu({
    required String storeId,
    required int languageId,
  }) async {
    try {
      final param =
          '?${ApiConfig.languageParam(languageId)}&${ApiConfig.userTypeParam()}';
      final path = ApiConfig.storesWithId(storeId) + ApiConfig.menus + param;
      final response = await dio.get(path);

      final MenuData menu = MenuDataDto.fromJson(response.data).toModel();

      return right(menu);
    } catch (e) {
      if (e is DioException && e.response != null) {
        logger.w(e.response?.data);
        return left(Failure.serverError());
      } else {
        logger.e(e);
        return left(Failure.unexpected());
      }
    }
  }

  @override
  Future<Option<Failure>> createOrderTicket({
    required OrderTicketData orderTicket,
  }) async {
    try {
      const path = ApiConfig.orderTickets;

      await dio.post(
        path,
        data: OrderTicketDataDto.fromModel(orderTicket).toJson(),
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
  Future<Either<Failure, List<OrderTicketData>>> getOrderTickets({
    required String userId,
  }) async {
    try {
      final param = '?${ApiConfig.userIdParam(userId)}';
      final path = ApiConfig.orderTickets + param;
      final response = await dio.get(path);

      final List<dynamic> _data = response.data;

      final List<OrderTicketData> orderTicketList = _data
          .map(
            (e) => OrderTicketDataDto.fromJson(e).toModel(),
          )
          .toList();

      return right(orderTicketList);
    } catch (e) {
      if (e is DioException && e.response != null) {
        logger.w(e.response?.data);
        return left(Failure.serverError());
      } else {
        logger.e(e);
        return left(Failure.unexpected());
      }
    }
  }
}
