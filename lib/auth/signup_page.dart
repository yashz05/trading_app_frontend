import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/class/auth_services.dart';
import 'package:trading_app_hackathon/class/otp_service.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import 'package:trading_app_hackathon/pages/home.dart';
import 'package:trading_app_hackathon/widgets/otp_widget.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signup_page extends StatefulWidget {
  final String pno;

  const signup_page({Key? key, required this.pno}) : super(key: key);

  @override
  State<signup_page> createState() => _signup_pageState();
}

class _signup_pageState extends State<signup_page>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int current_int = 0;
  auth_services aus = Get.put(auth_services());
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
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
      body: IndexedStack(
        index: current_int,
        children: [
          //fname lname
          SingleChildScrollView(
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
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Text(
                        "Signup",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: fname,
                        style: app_theme.ts_name,
                        decoration: InputDecoration(
                            hintStyle: app_theme.ts_qyt,
                            hintText: "Enter First Name",
                            filled: true,
                            fillColor: Colors.white24,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: lname,
                        style: app_theme.ts_name,
                        decoration: InputDecoration(
                            hintStyle: app_theme.ts_qyt,
                            hintText: "Enter Last Name",
                            filled: true,
                            fillColor: Colors.white24,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            )),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              current_int = 1;
                            });
                          },
                          color: app_theme.primary_color,
                          child: Text("Continue"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          //Set Pin
          SingleChildScrollView(
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
                        "Set Login Pin",
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
                            aus
                                .signup(
                                    fname.text,
                                    lname.text,
                                    widget.pno.toString().replaceAll("+91", ""),
                                    otps.otp)
                                .then((value) async {
                              SharedPreferences sd =
                                  await SharedPreferences.getInstance();
                              sd.setString("id", value.id!.oid.toString());
                              sd.setString("fname", value.firstName.toString());
                              sd.setString("lname", value.lastName.toString());
                              Get.to(home());
                            });
                          },
                          color: app_theme.primary_color,
                          child: Text(
                            "Sign Up",
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
        ],
      ),
    );
  }
}
