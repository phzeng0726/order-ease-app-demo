import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure({
    this.message,
  });
  final String? message;

  factory Failure.serverError() => const Failure(
        message: 'Server Error',
      );

  factory Failure.unexpected() => const Failure(
        message: 'Unexpected Error',
      );

  @override
  String toString() {
    return 'Failure: $message';
  }

  @override
  List<Object?> get props => [message];
}
