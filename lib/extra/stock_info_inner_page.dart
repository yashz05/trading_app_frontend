import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/class/paper_trade.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import 'package:trading_app_hackathon/model/stock_info_model.dart';
import 'package:get/get.dart';

class stock_info_inner extends StatelessWidget {
  final stock_info_model data;

  stock_info_inner({Key? key, required this.data}) : super(key: key);
  TextEditingController qyt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: data.name != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        textAlign: TextAlign.end,
                        style: app_theme.stock__info_tags,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.name!,
                        textAlign: TextAlign.end,
                        style: app_theme.ts_name,
                      )
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Listed ",
                        textAlign: TextAlign.end,
                        style: app_theme.stock__info_tags,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.exchange!,
                        textAlign: TextAlign.end,
                        style: app_theme.ts_name,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Open",
                        textAlign: TextAlign.end,
                        style: app_theme.stock__info_tags,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.open!,
                        textAlign: TextAlign.end,
                        style: app_theme.ts_name,
                      )
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "High ",
                        textAlign: TextAlign.end,
                        style: app_theme.stock__info_tags,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.high!,
                        textAlign: TextAlign.end,
                        style: app_theme.ts_name,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Low",
                        textAlign: TextAlign.end,
                        style: app_theme.stock__info_tags,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.low!,
                        textAlign: TextAlign.end,
                        style: app_theme.ts_name,
                      )
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 300,
                        child: Text(
                          "LTP ",
                          textAlign: TextAlign.end,
                          style: app_theme.stock__info_tags,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          data.close!,
                          textAlign: TextAlign.end,
                          style: app_theme.ts_name,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: app_theme.primary_color,
                      ),
                      onPressed: () {
                        trade_book(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Buy",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : SizedBox(
              height: 10,
              width: 10,
              child: Text(
                "Loading",
                style: app_theme.ts_name,
              )),
    );
  }

  trade_book(BuildContext ctx) {
    paper_trade pn = Get.put(paper_trade());
    showModalBottomSheet(
        context: ctx,
        backgroundColor: Colors.black,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            height: 600,
            color: Colors.black,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.name!,
                      style: app_theme.ts_name,
                    ),
                    Text(
                      "BUY ORDER",
                      style: TextStyle(
                          fontSize: 22,
                          color: app_theme.primary_color,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        "₹" + data.close!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 33,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        width: 300,
                        child: TextField(
                          controller: qyt,
                          textAlign: TextAlign.center,
                          cursorColor: app_theme.primary_color,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintStyle: app_theme.ts_qyt,
                            filled: true,
                            fillColor: Colors.white24,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "ENTER QUANITY",
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 200,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: app_theme.primary_color,
                          ),
                          onPressed: () {
                            print("NUY");
                            pn.trade("buy", data.symboltoken!,
                                int.parse(qyt.text), data.close.toString());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Place Order",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
