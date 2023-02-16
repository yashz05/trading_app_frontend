import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trading_app_hackathon/configs/backend_api.dart';
import 'package:trading_app_hackathon/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading_app_hackathon/pages/home.dart';

class auth_services extends GetxController {
  Future<int> check_pno(String pno) async {
    var url = backend_api.base_api + backend_api.check_user;

    var data = {"phone_no": pno.replaceAll("+91", "")};
    var resposne = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json"
      },
    );
    print(resposne.body);
    if (resposne.statusCode == 200) {
      var data = jsonDecode(resposne.body);
      return int.parse(data["code"].toString());
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

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      if (decoded["error"] == true) {
        Get.snackbar("Something Went Wrong", decoded["message"],
            colorText: Colors.white, barBlur: 30);
      } else {
        user_model data = user_model.fromJson(jsonDecode(response.body));

        return data;
      }
    }
    return user_model();
  }

  Future<user_model> getuser_data() async {
    SharedPreferences sd = await SharedPreferences.getInstance();
    var data = user_model(
      uid: sd.getString("id"),
      firstName: sd.getString("fname"),
      lastName: sd.getString("lname"),
    );

    return data;
  }

  Future verify_pin(String pno, String pin) async {
    var check_pin = await http.post(
      Uri.parse(backend_api.pin_verify),
      body: jsonEncode(
        {"phone_no": pno, "pin": pin},
      ),
      headers: {
        "accept": "application/json",
        "Content-Type": "application/json"
      },
    );
    if (check_pin.statusCode == 200) {
      var data = jsonDecode(check_pin.body);
      if (data["error"] == true) {
        Get.snackbar("Something Went Wrong", data["message"],
            colorText: Colors.white, backgroundColor: Colors.black);
      } else {
        SharedPreferences sd = await SharedPreferences.getInstance();
        sd.setString("id", data["uid"].toString());
        sd.setString("fname", data["first_name"].toString());
        sd.setString("lname", data["last_name"].toString());
        Get.to(home());
      }
    }
  }
}
