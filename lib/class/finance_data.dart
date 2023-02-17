import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trading_app_hackathon/auth/index.dart';
import 'package:trading_app_hackathon/configs/backend_api.dart';
import 'package:trading_app_hackathon/model/history_model.dart';
import 'package:trading_app_hackathon/model/ltp_quote.dart';
import 'package:trading_app_hackathon/configs/angel_endpoints.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class finance_data extends GetxController {
  RxString auth = "".obs;
  RxString refresh_token = "".obs;
  RxString feedtoken = "".obs;

  Future<String> get_ltp(String Symbol, String token, String exg) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${auth}',
      'Content-Type': 'application/json',
      'X-ClientLocalIP': '192.168.168.168',
      'X-ClientPublicIP': '192.168.168.168',
      'X-MACAddress': 'fe80::216e:6507:4b90:3719',
      'X-PrivateKey': 'zVMzZ7so',
      'X-SourceID': 'WEB',
      'X-UserType': 'USER',
    };

    var data = {"exchange": exg, "tradingsymbol": Symbol, "symboltoken": token};

    var url = Uri.parse(
      'https://apiconnect.angelbroking.com/order-service/rest/secure/angelbroking/order/v1/getLtpData',
    );
    var r = await http.post(url, body: jsonEncode(data), headers: headers);
    if (r.statusCode == 200) {
      ltp_quote ltp = ltp_quote.fromJson(jsonDecode(r.body));
      return ltp.data!.ltp.toString();
    }
    return "0";
  }

  Future<ltp_quote> ohlc(String Symbol, String token, String exg) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${auth}',
      'Content-Type': 'application/json',
      'X-ClientLocalIP': '192.168.168.168',
      'X-ClientPublicIP': '192.168.168.168',
      'X-MACAddress': 'fe80::216e:6507:4b90:3719',
      'X-PrivateKey': 'zVMzZ7so',
      'X-SourceID': 'WEB',
      'X-UserType': 'USER',
    };

    var data = {"exchange": exg, "tradingsymbol": Symbol, "symboltoken": token};

    var url = Uri.parse(
      'https://apiconnect.angelbroking.com/order-service/rest/secure/angelbroking/order/v1/getLtpData',
    );
    var r = await http.post(url, body: jsonEncode(data), headers: headers);
    print(r.body);
    if (r.statusCode == 200) {
      ltp_quote ltp = ltp_quote.fromJson(jsonDecode(r.body));
      return ltp;
    }
    return ltp_quote();
  }

  Future<List<double>> minichart_data(String excg, String token) async {
    //Get 10 days chart Data only

    var to = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var from = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(Duration(days: 10)));

    var body = {
      "exchange": "${excg}",
      "symboltoken": "${token}",
      "interval": "ONE_DAY",
      "fromdate": "${from} 09:15",
      "todate": "${to} 03:30"
    };

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${auth}',
      'Content-Type': 'application/json',
      'X-ClientLocalIP': '192.168.168.168',
      'X-ClientPublicIP': '192.168.168.168',
      'X-MACAddress': 'fe89::216e:6507:4b90:3719',
      'X-PrivateKey': 'zVMzZ7so',
      'X-SourceID': 'WEB',
      'X-UserType': 'USER',
    };

    var history_data = await http.post(Uri.parse(angel_endpoints.history_api),
        body: jsonEncode(body), headers: headers);
    print("called");
    if (history_data.statusCode == 200) {
      HistoryModel m = historyModelFromJson(history_data.body);
      List<double> close_vals = [];
      m.data.forEach((element) {
        close_vals.add(element[4]);
      });
      print(close_vals);
      return close_vals;
    }

    return [0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  }

  Future<List> quick_view_chart(String excg, String token) async {
    //Get 10 days chart Data only

    var to = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var from = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(Duration(days: 30)));

    var body = {
      "exchange": "${excg}",
      "symboltoken": "${token}",
      "interval": "ONE_DAY",
      "fromdate": "${from} 09:15",
      "todate": "${to} 03:30"
    };

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${auth}',
      'Content-Type': 'application/json',
      'X-ClientLocalIP': '192.168.168.168',
      'X-ClientPublicIP': '192.168.168.168',
      'X-MACAddress': 'fe89::216e:6507:4b90:3719',
      'X-PrivateKey': 'zVMzZ7so',
      'X-SourceID': 'WEB',
      'X-UserType': 'USER',
    };

    var history_data = await http.post(Uri.parse(angel_endpoints.history_api),
        body: jsonEncode(body), headers: headers);
    print("called");
    print(headers);
    if (history_data.statusCode == 200) {
      HistoryModel m = historyModelFromJson(history_data.body);

      List cld = [];
      m.data.forEach((element) {
        var daydata = {
          "day": DateFormat("yyyy-MM-dd")
              .parse(element[0])
              .millisecondsSinceEpoch
              .toDouble(),
          "value": element[4]
        };
        cld.add(daydata);
      });

      return cld;
    }

    return [];
  }

  Future<List> ltp_backup(String excg, String token) async {
    //Get 10 days chart Data only

    var to = DateFormat('yyyy-MM-dd').format(DateTime.now());

    var body = {
      "exchange": "${excg}",
      "symboltoken": "${token}",
      "interval": "ONE_DAY",
      "fromdate": "${to} 09:15",
      "todate": "${to} 03:30"
    };

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${auth}',
      'Content-Type': 'application/json',
      'X-ClientLocalIP': '192.168.168.168',
      'X-ClientPublicIP': '192.168.168.168',
      'X-MACAddress': 'fe89::216e:6507:4b90:3719',
      'X-PrivateKey': 'zVMzZ7so',
      'X-SourceID': 'WEB',
      'X-UserType': 'USER',
    };

    var history_data = await http.post(Uri.parse(angel_endpoints.history_api),
        body: jsonEncode(body), headers: headers);
    print("called");
    print(headers);
    if (history_data.statusCode == 200) {
      HistoryModel m = historyModelFromJson(history_data.body);

      List cld = [];
      m.data.forEach((element) {
        var daydata = {
          "day": DateFormat("yyyy-MM-dd")
              .parse(element[0])
              .millisecondsSinceEpoch
              .toDouble(),
          "value": element[4]
        };
        cld.add(daydata);
      });

      return cld;
    }

    return [];
  }

  Future<List> candle_stick_data(String excg, String token) async {
    //Get 10 days chart Data only

    var to = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var from = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(Duration(days: 200)));

    var body = {
      "exchange": "${excg}",
      "symboltoken": "${token}",
      "interval": "ONE_DAY",
      "fromdate": "${from} 09:15",
      "todate": "${to} 03:30"
    };

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${auth}',
      'Content-Type': 'application/json',
      'X-ClientLocalIP': '192.168.168.168',
      'X-ClientPublicIP': '192.168.168.168',
      'X-MACAddress': 'fe89::216e:6507:4b90:3719',
      'X-PrivateKey': 'zVMzZ7so',
      'X-SourceID': 'WEB',
      'X-UserType': 'USER',
    };

    var history_data = await http.post(Uri.parse(angel_endpoints.history_api),
        body: jsonEncode(body), headers: headers);
    print(headers);
    if (history_data.statusCode == 200) {
      HistoryModel m = historyModelFromJson(history_data.body);
      print(history_data.body);
      List cld = [];
      m.data.forEach((element) {
        //converting to UNOX TIMESTAMP OR EPOCH because C
        element[0] =
            DateFormat("yyyy-MM-dd").parse(element[0]).millisecondsSinceEpoch;
        element[1] = element[1].toString();
        element[2] = element[2].toString();
        element[3] = element[3].toString();
        element[4] = element[4].toString();
        element[5] = element[5].toString();
      });

      return m.data;
    } else {
      print(history_data.body);
    }

    return [];
  }

  Future get_tokens() async {
    SharedPreferences sd = await SharedPreferences.getInstance();
    var id = sd.getString("id");
    print(id);
    try {
      var response = await http.post(
          Uri.parse(backend_api.base_api + "user/check-login-access"),
          body: jsonEncode({"uid": id}),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        auth.value = data["jwtToken"];
        refresh_token.value = data["refreshToken"];
        feedtoken.value = data["feedToken"];
      } else {
        throw (response.body);
      }
    } catch (e) {
      print(e);
      // Get.offAll(index());
    }
  }
}
