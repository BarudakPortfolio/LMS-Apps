import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';

String exceptionTomessage(Object exception) {
  String errorMsg = "";
  if (exception is SocketException) {
    errorMsg = "Tidak ada Internet, coba kembali";
  } else if (exception is ClientException) {
    errorMsg = "Internet lemah, harap coba kembali";
  } else {
    errorMsg = "Harap coba kembali";
  }
  log(errorMsg, error: exception, name: "EXCEPTION ERROR");
  return errorMsg;
}