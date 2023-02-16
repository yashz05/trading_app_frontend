import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/class/otp_service.dart';
import 'package:trading_app_hackathon/widgets/otp_widget.dart';
import 'package:trading_app_hackathon/class/auth_services.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import 'package:get/get.dart';

class login_page extends StatefulWidget {
  final String pno;

  const login_page({Key? key, required this.pno}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  auth_services aus = Get.put(auth_services());
  otp_service otps = Get.put(otp_service());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/index_header.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Text(
                    "Enter Login Pin",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.18),
                    child: otp_widget(size: 4),
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: MaterialButton(
                      onPressed: () {
                        print("called");
                        aus
                            .verify_pin(
                                widget.pno.toString().replaceAll("+91", ""),
                                otps.otp)
                            .then((value) {});
                      },
                      color: app_theme.primary_color,
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
