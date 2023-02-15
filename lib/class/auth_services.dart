import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trading_app_hackathon/configs/backend_api.dart';
import 'package:trading_app_hackathon/model/user_model.dart';

class auth_services extends GetxController {
  Future<int> check_pno(String pno) async {
    var url = backend_api.base_api + backend_api.check_user;

    var data = {"phone_no": pno};
    var resposne = await http.post(Uri.parse(url), body: data);
    if (resposne.statusCode == 200) {
      return int.parse(resposne.body.toString());
    } else {
      return -2;
    }
  }

  Future<user_model> signup(
      String fname, String lastname, String pno, String pin) async {
    var body = {
      "first_name": fname,
      "last_name": lastname,
      "phone_no": pno,
      "pin": pin
    };
    var n = json.encode(body);
    var response = await http.post(
      Uri.parse(backend_api.signup),
      body: n,
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json"
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      user_model data = user_model.fromJson(json.decode(response.body));
      return data;
    }
    return user_model();
  }
}
