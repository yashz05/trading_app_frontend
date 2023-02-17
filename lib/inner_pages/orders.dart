import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/class/backend_service.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import 'package:get/get.dart';

class orders_page extends StatefulWidget {
  const orders_page({Key? key}) : super(key: key);

  @override
  State<orders_page> createState() => _orders_pageState();
}

class _orders_pageState extends State<orders_page>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  backend_service ns = Get.put(backend_service());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    ns.get_orders();
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
          Obx(() => ListView.builder(
              itemCount: ns.orders.length,
              padding: EdgeInsets.only(top: 100),
              itemBuilder: (BuildContext ct, int i) {
                return Container(
                  color: Colors.black,
                  child: ListTile(
                    title: Text(
                      ns.orders[i].name!,
                      style: app_theme.ts_name,
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ns.orders[i].buyRate != 0
                              ? "Buy Rate " + ns.orders[i].buyRate.toString()
                              : "Sell Rate " + ns.orders[i].sellRate.toString(),
                          style: app_theme.ts_qyt,
                        ),
                        Text(
                          "Qyt : " + ns.orders[i].qty.toString(),
                          style: app_theme.ts_qyt,
                        ),
                      ],
                    ),
                    trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Trade Value "
                                ,
                            style: app_theme.ts_qyt,
                          ),
                          Text("₹"+(ns.orders[i].qty! *
                              double.parse(
                                  ns.orders[i].buyRate.toString()))
                              .toString(),style: app_theme.ts_name,)
                        ]),
                  ),
                );
              }))
        ]));
  }
}
