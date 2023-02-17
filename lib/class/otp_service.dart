import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:trading_app_hackathon/configs/twillo_config.dart';

class otp_service extends GetxController {
  String otp = "";

  Future generate_otp(String pno) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': twillo_config.authn,
    };

    var data = {
      'To': pno,
      'Channel': 'sms',
    };
    var url = Uri.parse(
        'https://verify.twilio.com/v2/Services/${twillo_config.sid}/Verifications');
    var res = await http.post(url, headers: headers, body: data);
    print(res.body);
    if (res.statusCode != 201)
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    print(res.body);
  }

  Future<int> verify_otp(String pno) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': twillo_config.authn,
    };

    var data = {
      'To': pno,
      'Code': otp,
    };

    var url = Uri.parse(
        'https://verify.twilio.com/v2/Services/${twillo_config.sid}/VerificationCheck');
    var res = await http.post(url, headers: headers, body: data);

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      if (data["status"] == "approved") {
        return 1;
      } else {
        return -1;
      }
    }
    return 0;
  }
}
