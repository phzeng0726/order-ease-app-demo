part of 'menu_watcher_bloc.dart';

@immutable
sealed class MenuWatcherEvent {
  const MenuWatcherEvent();
}

class ScanQRCodeEvent extends MenuWatcherEvent {
  const ScanQRCodeEvent({
    required this.storeSeatId,
  });
  final String storeSeatId;
}

class FetchMenuEvent extends MenuWatcherEvent {
  const FetchMenuEvent({
    required int languageId,
  });
}
