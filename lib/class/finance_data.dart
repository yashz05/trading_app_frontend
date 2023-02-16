import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trading_app_hackathon/model/ltp_quote.dart';

class finance_data extends GetxController {
  String auth =
      "eyJhbGciOiJIUzUxMiJ9.eyJ1c2VybmFtZSI6IlNUUk4xMDYyIiwicm9sZXMiOjAsInVzZXJ0eXBlIjoiVVNFUiIsImlhdCI6MTY3NjUyNDgzOSwiZXhwIjoxNzYyOTI0ODM5fQ.Snk3bV4p-efTkc_6na02BaKj3n8RFYhm_gK5vsNRUOzliMr11Xssvu5vUVuhzC_rFixcY9sndidC3LQtwSFWaQ";
  String refresh_token =
      "eyJhbGciOiJIUzUxMiJ9.eyJ0b2tlbiI6IlJFRlJFU0gtVE9LRU4iLCJpYXQiOjE2NzY1MjQ4Mzl9.rbLQpa-2YsAuYU60psMV00KC8PlOtAqwoHs8AmZb5CqrPFfNA8yn-t34m0nflERvgPGVn3PQ-oC3rE6PvvX0QA";
  String feedtoken = "0806354284";

  Future<String> get_ltp(String Symbol, String token) async {
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

    var data = {
      "exchange": "NSE",
      "tradingsymbol": "SBIN-EQ",
      "symboltoken": "3045"
    };

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
}
