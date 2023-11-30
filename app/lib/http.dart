import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:ordering_system_client_app/configurations.dart';

// NOTE: https://pub.dev/packages/dio#creating-an-instance-and-set-default-configs
// It is recommended to use a singleton of Dio in projects, which can manage configurations like headers, base urls, and timeouts consistently. Here is an example that use a singleton in Flutter.
final dio = Dio(
  BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 3), // response == null
    receiveTimeout: const Duration(seconds: 5),
  ),
);

// For error handle
final logger = Logger(
  printer: PrettyPrinter(
    printTime: true,
  ),
);
