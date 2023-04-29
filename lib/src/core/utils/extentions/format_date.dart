import 'package:intl/intl.dart';

formatDate(String date) {
  var format = DateFormat('EEEE, dd-mm-yyyy', 'id_ID');
  var formatted = format.format(DateTime.parse(date));
  return formatted;
}

formatBornDate(String date) {
  var format = DateFormat('dd MMMM yyyy');
  var formatted = format.format(DateTime.parse(date));
  return formatted;
}

formatDay(String date) {
  var format = DateFormat('EEEE', 'id_ID');
  var formatted = format.format(DateTime.parse(date));
  return formatted;
}
