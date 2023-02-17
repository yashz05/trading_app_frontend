import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/auth/index.dart';
import 'package:trading_app_hackathon/class/finance_data.dart';
import 'package:get/get.dart';
import 'package:trading_app_hackathon/configs/theme.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  finance_data fd = Get.put(finance_data());

  @override
  void initState() {
    super.initState();
    fd.get_tokens().then((value) {
      Future.delayed(Duration(seconds: 1));
      Get.offAll(index());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/icon-512.png",
          width: 150,
        ),
        SizedBox(
          height: 100,
        ),
        SizedBox(
            width: 100,
            child: LinearProgressIndicator(
              color: app_theme.primary_color,
            )),
      ],
    );
  }
}
