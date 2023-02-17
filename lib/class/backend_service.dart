import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:trading_app_hackathon/configs/backend_api.dart';
import 'package:trading_app_hackathon/model/search_model.dart';
import 'package:trading_app_hackathon/model/orders_model.dart';

class backend_service extends GetxController {
  RxList<orders_model> orders = <orders_model>[].obs;

  void sync_watchlist() async {
    SharedPreferences sd = await SharedPreferences.getInstance();
    var wl = sd.getString("watch_list");
    var id = sd.getString("id");
    List<String> twl = [];

    List<search_model> sml = (json.decode(wl.toString()) as List)
        .map((data) => search_model.fromJson(data))
        .toList();
    sml.forEach((element) {
      twl.add(element.token.toString());
    });
    var dwl = json.encode(twl);
    var resposne = await http.post(
      Uri.parse(backend_api.sync_watchlist),
      body: jsonEncode({"stock_ids": twl, "user_id": id}),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );
    if (resposne.statusCode != 200) {
      print(resposne.body);
      print(jsonEncode({"stock_ids": twl, "user_id": sd.getString("id")}));
      Get.snackbar("Alert", "Error Saving Watchlist", barBlur: 10);
    } else {}
  }

  void get_watchlist_stock() async {}

  void get_orders() async {
    SharedPreferences sd = await SharedPreferences.getInstance();
    var id = sd.getString("id");
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var data = {"uid": id};

    var url = Uri.parse('http://128.199.17.71:8090/user/orders');
    var res = await http.post(url, headers: headers, body: jsonEncode(data));
    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    print(res.body);
    List<orders_model> ordl = (json.decode(res.body) as List)
        .map((data) => orders_model.fromJson(data))
        .toList();
    orders.value = ordl;
  }
}
