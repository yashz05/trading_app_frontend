import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/configs/theme.dart';

class index extends StatefulWidget {
  const index({Key? key}) : super(key: key);

  @override
  State<index> createState() => _indexState();
}

class _indexState extends State<index> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  hintStyle: app_theme.ts_qyt,
                  filled: true,
                  fillColor: Colors.white24,
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: MaterialButton(
                color: app_theme.primary_color,
                onPressed: () {
                  print("");
                },
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
