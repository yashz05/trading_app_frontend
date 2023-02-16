import 'package:get/get.dart';

class finance_data extends GetxController {
  Future<String> get_ltp(String Symbol, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzUxMiJ9.eyJ1c2VybmFtZSI6IlNUUk4xMDYyIiwicm9sZXMiOjAsInVzZXJ0eXBlIjoiVVNFUiIsImlhdCI6MTY3NDcyNDI5NywiZXhwIjoxNzYxMTI0Mjk3fQ.y390fyOq4oNUtuQnda8QxCw_77Whui1q5zLgLjVfCol3hPXkW-ZaEonm1AATnA9c-GoDUUEQgEJHKWPBtgGXXA',
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
        'https://apiconnect.angelbroking.com/order-service/rest/secure/angelbroking/order/v1/getLtpData');
    return "";
  }
}
