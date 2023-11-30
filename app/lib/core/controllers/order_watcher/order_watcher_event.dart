part of 'order_watcher_bloc.dart';

@immutable
sealed class OrderWatcherEvent {
  const OrderWatcherEvent();
}

class FetchOrderHistoryEvent extends OrderWatcherEvent {
  const FetchOrderHistoryEvent({
    required this.userId,
  });
  final String userId;
}
