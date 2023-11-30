import 'package:intl/intl.dart';

class DateTimeConverter {
  const DateTimeConverter(this.value);

  final DateTime value;

  factory DateTimeConverter.fromString(String time) => DateTimeConverter(
        DateTime.parse(time),
      );

  // 將輸入的UTC+0時間轉換成local，並用成需要的格式
  String toLocalTimeString() => DateFormat('yyyy-MM-dd HH:mm:ss').format(
        value.toLocal(),
      );

  DateTime toDateTime() => value;
}
