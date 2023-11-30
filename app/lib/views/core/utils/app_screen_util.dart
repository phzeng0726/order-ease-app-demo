import 'package:ordering_system_client_app/core/models/enums/load_status_enum.dart';

class AppScreenUtil {
  static void whenLoadStatus(
    LoadStatus status, {
    void Function()? initial,
    void Function()? inProgress,
    void Function()? succeed,
    void Function()? failed,
  }) {
    if (status == LoadStatus.initial) {
      initial?.call();
    } else if (status == LoadStatus.inProgress) {
      inProgress?.call();
    } else if (status == LoadStatus.succeed) {
      succeed?.call();
    } else if (status == LoadStatus.failed) {
      failed?.call();
    }
  }

  static void mapLoadStatus(
    LoadStatus status, {
    required void Function() initial,
    required void Function() inProgress,
    required void Function() succeed,
    required void Function() failed,
  }) {
    if (status == LoadStatus.initial) {
      initial();
    } else if (status == LoadStatus.inProgress) {
      inProgress();
    } else if (status == LoadStatus.succeed) {
      succeed();
    } else if (status == LoadStatus.failed) {
      failed();
    }
  }
}
