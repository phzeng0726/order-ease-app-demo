import 'package:flutter_dotenv/flutter_dotenv.dart';

const int defaultUserType = 1; // 客戶端app為1，商家端app為0
const int languageId = 2; // 1: en, 2: zh

final String environment = dotenv.env['ENVIRONMENT'] ?? '';
final String endpoint = dotenv.env['ENDPOINT'] ?? '';
final String baseUrl = dotenv.env['BASE_URL'] ?? '';
