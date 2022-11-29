import 'package:intl/intl.dart';

void main() {
  var dateTime = DateTime.now();
  String formattedDate = DateFormat("dd/MM/yyyy").format(dateTime);
  print(formattedDate);
}