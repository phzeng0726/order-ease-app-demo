import 'package:dartz/dartz.dart';
import 'package:ordering_system_client_app/core/models/core/failure.dart';
import 'package:ordering_system_client_app/core/models/menu_data.dart';
import 'package:ordering_system_client_app/core/models/order_ticket_data.dart';

abstract class IOrderRepository {
  // 獲取菜單資訊
  Future<Either<Failure, MenuData>> getStoreMenu({
    required String storeId,
    required int languageId,
  });

  // 送出訂單
  Future<Option<Failure>> createOrderTicket({
    required OrderTicketData orderTicket,
  });

  // 獲取訂單歷史紀錄
  Future<Either<Failure, List<OrderTicketData>>> getOrderTickets({
    required String userId,
  });
}
