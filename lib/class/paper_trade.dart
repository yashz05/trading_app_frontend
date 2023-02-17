import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading_app_hackathon/configs/backend_api.dart';
import 'package:trading_app_hackathon/configs/backend_api.dart';

class paper_trade extends GetxController {
  var demat_amount = 0.0.obs;

  void get_demat() async {
    SharedPreferences sd = await SharedPreferences.getInstance();
    var id = sd.getString("id");
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var data = {"uid": id};

    var url = Uri.parse('${backend_api.base_api}user/get-balance');
    var res = await http.post(url, headers: headers, body: jsonEncode(data));
    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    var bal = jsonDecode(res.body);
    print(bal[0]["balance"].runtimeType);
    demat_amount.value = double.parse(bal[0]["balance"].toString());
  }

  void trade(String type, String token, int qyt, String buy) async {
    SharedPreferences sd = await SharedPreferences.getInstance();
    var id = sd.getString("id");
    print(id);
    var body = {
      "uid": id,
      "type": type,
      "token": token,
      "qty": qyt,
      "transaction_id": "",
      "buy_rate": buy,
      "sell_rate": 0
    };
    print("call");
    try {
      var trade = await http.post(
        Uri.parse(backend_api.base_api + "trade/place/order"),
        body: jsonEncode(body),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json"
        },
      );
      print(trade.body);
      if (trade.statusCode == 200) {
        var data = jsonDecode(trade.body);
        if (data["error"] == false) {
          Get.back();

          if(type == "buy"){
            Get.snackbar("Alert", "Added to Portfolio",
                backgroundColor: Colors.black, colorText: Colors.white);
          }else{
            Get.snackbar("Alert", "Removed From Portfolio",
                backgroundColor: Colors.black, colorText: Colors.white);
          }
          get_demat();
        } else {
          Get.snackbar("Alert", "Please contact Admin",
              backgroundColor: Colors.black, colorText: Colors.white);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> get_portfolio() async {
    SharedPreferences sd = await SharedPreferences.getInstance();
    var id = sd.getString("id");
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var data = {"uid": id};

    var url = Uri.parse('http://128.199.17.71:8090/user/portfolio');
    var res = await http.post(url, headers: headers, body: jsonEncode(data));
    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    print(res.body);

    var li = jsonDecode(res.body);
    return li;
  }

}
