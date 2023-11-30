part of 'menu_watcher_bloc.dart';

class MenuWatcherState extends Equatable {
  const MenuWatcherState({
    required this.storeSeatId,
    required this.menu,
    required this.failureOption,
    required this.status,
  });

  final String storeSeatId;
  final MenuData menu;
  final Option<Failure> failureOption;
  final LoadStatus status;

  factory MenuWatcherState.initial() => MenuWatcherState(
        storeSeatId: '',
        menu: MenuData.empty(),
        failureOption: none(),
        status: LoadStatus.initial,
      );

  MenuWatcherState copyWith({
    String? storeSeatId,
    MenuData? menu,
    Option<Failure>? failureOption,
    LoadStatus? status,
  }) {
    return MenuWatcherState(
      storeSeatId: storeSeatId ?? this.storeSeatId,
      menu: menu ?? this.menu,
      failureOption: failureOption ?? this.failureOption,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        storeSeatId,
        menu,
        failureOption,
        status,
      ];
}
