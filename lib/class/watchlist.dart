import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading_app_hackathon/class/backend_service.dart';

class watch_lsit extends GetxController {
  backend_service  bs = Get.put(backend_service());
  RxList<String> watch_list = <String>[].obs;

  void ad_to_watch_list(String id) async {
    if (!watch_list.contains(id)) {
      watch_list.add(id);
    }

    SharedPreferences sd = await SharedPreferences.getInstance();
    sd.setStringList("watch_list", watch_list);
    bs.sync_watchlist();
  }

  Future get_watch_list() async {
    SharedPreferences sd = await SharedPreferences.getInstance();
    var wl = sd.getStringList("watch_list");
    watch_list.value = wl!;
    print(watch_list);
  }
}
