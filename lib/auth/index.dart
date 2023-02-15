import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/auth/otp_page.dart';
import 'package:trading_app_hackathon/class/auth_services.dart';
import 'package:trading_app_hackathon/class/otp_service.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import 'package:get/get.dart';

class index extends StatefulWidget {
  const index({Key? key}) : super(key: key);

  @override
  State<index> createState() => _indexState();
}

class _indexState extends State<index> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController pno = TextEditingController();
  otp_service otps = Get.put(otp_service());

  bool loading = false;

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
        child: Column(
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/index_header.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: null /* add child content here */,
            ),
            SizedBox(
              height: 130,
            ),
            Text(
              "Enter Phone Number",
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: pno,
                style: app_theme.ts_name,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  hintStyle: app_theme.ts_qyt,
                  filled: true,
                  fillColor: Colors.white24,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (pno.text.isEmpty) {
                  Get.snackbar("Alert", "Pleas Enter Phone Number",
                      colorText: Colors.white, barBlur: 30);
                  setState(() {
                    loading = false;
                  });
                } else {

                  setState(() {
                    loading = !loading;
                  });
                  otps.generate_otp("+91" + pno.text).then((value) {
                    setState(() {
                      loading = false;
                    });
                    Get.to(otp_page(pno: "+91" + pno.text));
                  });
                }
              },
              child: AnimatedContainer(
                decoration: BoxDecoration(
                    color: app_theme.primary_color,
                    border: Border.all(
                      color: app_theme.primary_color,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                width: loading == false ? 250 : 100,
                height: loading == false ? 50 : 60,
                padding: EdgeInsets.all(10),
                duration: Duration(milliseconds: 500),
                child: loading == false
                    ? Text(
                        "Continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
