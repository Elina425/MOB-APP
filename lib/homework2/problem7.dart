import 'package:intl/intl.dart';

void main() {
  DateTime now = DateTime.now();

  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm:ss').format(now);

  print("Current date and time: $formattedDate");
}