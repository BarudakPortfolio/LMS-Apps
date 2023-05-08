import 'package:intl/intl.dart';

formatDate(String date) {
  var format = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
  var formatted = format.format(DateTime.parse(date));
  return formatted;
}

formatBornDate(String date) {
  var format = DateFormat('dd MMMM yyyy', 'id_ID');
  var formatted = format.format(DateTime.parse(date));
  return formatted;
}

formatDay(String date) {
  var format = DateFormat('EEEE', 'id_ID');
  var formatted = format.format(DateTime.parse(date));
  return formatted;
}

dynamic formatDatetimeNumber(String date) {
  var format = DateFormat('EE dd MMM yyyy, H:m', 'id_ID');
  var formatted = format.format(DateTime.parse(date));
  return formatted;
}

formatDateToNumber(String date) {
  var format = DateFormat('EEEE dd-mm-yyyy', 'id_ID');
  var formatted = format.format(DateTime.parse(date));
  return formatted;
}

int dayToNumber(String day) {
  switch (day.toLowerCase()) {
    case 'senin':
      return 0;
    case 'selasa':
      return 1;
    case 'rabu':
      return 2;
    case 'kamis':
      return 3;
    case 'jumat':
      return 4;
    case 'sabtu':
      return 5;
    default:
      throw Exception('Invalid day : $day');
  }
}
