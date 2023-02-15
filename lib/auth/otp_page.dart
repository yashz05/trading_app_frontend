import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/auth/signup_page.dart';
import 'package:trading_app_hackathon/class/auth_services.dart';
import 'package:trading_app_hackathon/class/otp_service.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import 'package:trading_app_hackathon/pages/home.dart';
import 'package:trading_app_hackathon/widgets/otp_widget.dart';
import 'package:get/get.dart';

class otp_page extends StatefulWidget {
  final String pno;

  const otp_page({Key? key, required this.pno}) : super(key: key);

  @override
  State<otp_page> createState() => _otp_pageState();
}

class _otp_pageState extends State<otp_page>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  otp_service otps = Get.put(otp_service());
  auth_services aus = Get.put(auth_services());

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
        child: Container(
          height: 800,
          child: Stack(
            children: [
              Positioned(
                top: -200,
                left: 100,
                right: -50,
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/otp_header.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: null /* add child content here */,
                ),
              ),
              Center(
                  child: Text(
                "ENTER OTP \n  Sent on ${widget.pno}",
                textAlign: TextAlign.center,
                style: app_theme.ts_name,
              )),
              Positioned(
                  top: 500,
                  left: 10,
                  right: -50,
                  child: otp_widget(
                    size: 6,
                  )),
              Positioned(
                  top: 600,
                  left: 120,
                  child: SizedBox(
                    width: 200,
                    child: MaterialButton(
                      onPressed: () {
                        otps.verify_otp(widget.pno).then((value) {
                          if (value == 1) {
                            aus.check_pno(widget.pno).then((value) {
                              if (value == 1) {
                                //go to LOGIN PAGE
                              } else {
                                //GO TO SING UP PAGE
                                Get.offAll(signup_page(pno: widget.pno));
                              }
                            });
                          } else if (value == -1) {
                            Get.snackbar("Alert", "OTP INVALID",
                                colorText: Colors.white, barBlur: 30);
                          }
                        });
                      },
                      color: app_theme.primary_color,
                      child: Text("Verify"),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
