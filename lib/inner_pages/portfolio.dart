import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/class/auth_services.dart';
import 'package:trading_app_hackathon/class/paper_trade.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import 'package:get/get.dart';
import 'package:trading_app_hackathon/model/user_model.dart';

class portfolio_innerlist extends StatefulWidget {
  const portfolio_innerlist({Key? key}) : super(key: key);

  @override
  State<portfolio_innerlist> createState() => _portfolio_innerlistState();
}

class _portfolio_innerlistState extends State<portfolio_innerlist>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  auth_services aus = Get.put(auth_services());
  user_model um = user_model();
  paper_trade pd = Get.put(paper_trade());
  List<dynamic> pl = [];
  double total = 0;
  late Timer t;
  int l = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    t = Timer.periodic(Duration(seconds: 2), (timer) {
      pd.get_demat();
      pd.get_portfolio().then((value) {
        setState(() {
          pl = value;
        });
        pl.forEach((element) {
          if (l < 1) {
            setState(() {
              l++;
              total += int.parse(element["qty"].toString()) *
                  double.parse(element["buy_rate"].toString());
            });
          }
        });
      });
    });

    aus.getuser_data().then((value) {
      setState(() {
        um = value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    t.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.grey.shade900,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(""),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "₹" + total.toString(),
                style: TextStyle(color: app_theme.primary_color, fontSize: 40),
              ),
            )
          ],
        ),
      ),
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
      body: Stack(
        children: [
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
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hello, ${um.firstName}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(13),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                        colors: [
                          Color(0xffbdd9eb),
                          Color(0xfffce4c0),
                          Color(0xfff479af),
                        ],
                        begin: const FractionalOffset(-0.5, 1),
                        end: const FractionalOffset(1.6, -1),
                        stops: [0.3, 0.4, 0.8],
                        tileMode: TileMode.clamp),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Balance',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(() => Text(
                            "₹" + pd.demat_amount.floorToDouble().toString(),
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w900),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: app_theme.primary_color,
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Deposit",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: OutlinedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Withdraw",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        onPressed: () {
                          print("it's pressed");
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                              width: 2.0, color: app_theme.primary_color),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                    color: Colors.black,
                    child: pl != null
                        ? ListView.builder(
                            itemCount: pl.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext ctx, int i) {
                              return ListTile(
                                onTap: () {
                                  print("SELL");
                                  pd.trade(
                                      "Sell",
                                      pl[i]["token"]!,
                                      int.parse(pl[i]["qty"].toString()),
                                      pl[i]["buy_rate"].toString());
                                },
                                title: Text(
                                  pl[i]["name"].toString(),
                                  style: app_theme.ts_price,
                                ),
                                trailing: Text(
                                  "₹" + pl[i]["buy_rate"].toString(),
                                  style: app_theme.ts_price,
                                ),
                                subtitle: Text(
                                  pl[i]["qty"].toString() + " qyt",
                                  style: app_theme.ts_qyt,
                                ),
                              );
                            })
                        : SizedBox(
                            child: Text(
                              "No Stocks",
                              style: app_theme.ts_name,
                            ),
                          ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
