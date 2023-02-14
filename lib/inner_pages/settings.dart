import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/configs/theme.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings>
    with SingleTickerProviderStateMixin {
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
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined))
          ],
          backgroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              minRadius: 5,
              backgroundColor: app_theme.primary_color,
              child: Text(
                "TA",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        ),
        body: Stack(children: [
          Container(
              margin: EdgeInsets.only(bottom: 150),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: null),
        ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [


          ],
        )
        ]));
  }
}
