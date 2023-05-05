import 'dart:developer';

import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:lms/src/models/user.dart';

import '../../../core/common/constants.dart';

class CollectUserApi{
  final IOClient client;

  CollectUserApi(this.client);

  Future sendDataUser(UserModel user)async{
    Uri url = Uri.parse("$BASE_USER_URL?action=insert");

    Map<String, dynamic> data = user.toJson();
    Response response = await client.post(url, body: data);
    inspect(response.body);

  }
}