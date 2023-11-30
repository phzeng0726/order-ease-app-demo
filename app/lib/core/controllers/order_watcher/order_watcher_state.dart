part of 'order_watcher_bloc.dart';

class OrderWatcherState extends Equatable {
  const OrderWatcherState({
    required this.orderTicketList,
    required this.failureOption,
    required this.status,
  });

  final List<OrderTicketData> orderTicketList;
  final Option<Failure> failureOption;
  final LoadStatus status;

  factory OrderWatcherState.initial() => OrderWatcherState(
        orderTicketList: const <OrderTicketData>[],
        failureOption: none(),
        status: LoadStatus.initial,
      );

  OrderWatcherState copyWith({
    List<OrderTicketData>? orderTicketList,
    Option<Failure>? failureOption,
    LoadStatus? status,
  }) {
    return OrderWatcherState(
      orderTicketList: orderTicketList ?? this.orderTicketList,
      failureOption: failureOption ?? this.failureOption,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        orderTicketList,
        failureOption,
        status,
      ];
}
