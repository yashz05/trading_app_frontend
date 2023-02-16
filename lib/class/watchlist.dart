import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading_app_hackathon/class/backend_service.dart';
import 'package:http/http.dart' as http;
import 'package:trading_app_hackathon/configs/backend_api.dart';
import 'package:trading_app_hackathon/model/search_model.dart';

class watch_lsit extends GetxController {
  backend_service bs = Get.put(backend_service());
  RxList<search_model> watch_list = <search_model>[].obs;

  void ad_to_watch_list(search_model id) async {
    if (!watch_list.contains(id)) {
      watch_list.add(id);
    }

    SharedPreferences sd = await SharedPreferences.getInstance();
    sd.setString("watch_list", jsonEncode(watch_list));
    // bs.sync_watchlist();
    //BUG FOUND
  }
    void save_watchlist() async {
      SharedPreferences sd = await SharedPreferences.getInstance();
      sd.setString("watch_list", jsonEncode(watch_list));
    }

  Future get_watch_list() async {
    SharedPreferences sd = await SharedPreferences.getInstance();
    var wl = sd.getString("watch_list");
    List<search_model> sml = (json.decode(wl.toString()) as List)
        .map((data) => search_model.fromJson(data))
        .toList();
    watch_list.value = sml;
    // print(watch_list);
  }

  Future get_watch_list_from_server() async {
    SharedPreferences sd = await SharedPreferences.getInstance();
    var id = sd.getString("id");
    print(id);
    var r = await http.post(Uri.parse(backend_api.get_fav_list),
        body: jsonEncode({"uid": id}));
    print("object");
    print(r.body);
  }
}
