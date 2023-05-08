import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:lms/src/features/http/provider/http_provider.dart';
import 'package:lms/src/models/user.dart';

import '../../../core/common/constants.dart';

final collectdataProvider =
    Provider<CollectUserApi>((ref) => CollectUserApi(ref.watch(httpProvider)));

class CollectUserApi {
  final IOClient client;

  CollectUserApi(this.client);

  Future sendDataUser(UserModel user) async {
    print("SEND DATA >>>>>");
    Uri url = Uri.parse("$BASE_USER_URL?action=insert");

    Map<String, dynamic> data = user.toJson();
    Response response = await client.post(url, body: jsonEncode(data));
  }

  Future sendReviewUser(UserModel user, int star, String reviews) async {
    Uri url = Uri.parse("$BASE_USER_URL?action=review");

    Map<String, dynamic> data = {
      "id": user.idUser,
      "value": star,
      "pesan": reviews,
    };

    Response response = await client.post(url, body: jsonEncode(data));
  }
}
