import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/class/otp_service.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import 'package:trading_app_hackathon/class/otp_service.dart';
import 'package:get/get.dart';

class otp_widget extends StatelessWidget {
  final int size;

  const otp_widget({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //saving all char or digits of otp in controller list
    List<TextEditingController> _textcontrollers = [];
    String otp = "";
    otp_service otps = Get.put(otp_service());
    return Container(
      height: 400,
      child: ListView.builder(
          itemCount: size,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext ct, int index) {
            _textcontrollers.add(TextEditingController());

            return SizedBox(
              width: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textcontrollers[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (n) {
                    if (n.length < 1) {
                      if (index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    } else {
                      if (index < size) {
                        FocusScope.of(context).nextFocus();
                      }
                    }
                    otp = "";
                    _textcontrollers.forEach((element) {
                      otp += element.text.toString();
                    });
                    otps.otp = otp;
                    print(otps.otp);
                  },
                  style: app_theme.ts_name,
                  maxLength: 1,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white24,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      )),
                ),
              ),
            );
          }),
    );
  }
}
