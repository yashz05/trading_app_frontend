import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/class/finance_data.dart';
import 'package:trading_app_hackathon/configs/theme.dart';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:get/get.dart';
import 'package:trading_app_hackathon/model/stock_info_model.dart';
import 'package:trading_app_hackathon/stock_pages/stock_info.dart';
import 'package:trading_app_hackathon/class/watchlist.dart';
import 'package:fl_chart/fl_chart.dart';

class home_innerlist extends StatefulWidget {
  const home_innerlist({Key? key}) : super(key: key);

  @override
  State<home_innerlist> createState() => _home_innerlistState();
}

class _home_innerlistState extends State<home_innerlist>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  watch_lsit gwl = Get.put(watch_lsit());
  finance_data fd = Get.put(finance_data());
  bool wl_loading = true;
  List cld = [];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.white, fontSize: 10);
    String text;
    text = value.toString();

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 6,
      child: Text(text, style: style, textAlign: TextAlign.center),
    );
  }

  Widget bottomwidget(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.white, fontSize: 10);
    String text;
    text = DateTime.fromMillisecondsSinceEpoch(value.toInt(), isUtc: true)
            .add(Duration(days: 1))
            .day
            .toString() +
        '/' +
        DateTime.fromMillisecondsSinceEpoch(value.toInt(), isUtc: true)
            .month
            .toString();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 6,
      child: Text(text, style: style, textAlign: TextAlign.center),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    gwl.get_watch_list().then((value) {

      setState(() {
        wl_loading = !wl_loading;
      });
    });
    fd.quick_view_chart("NSE", "11971").then((value) {
      setState(() {
        cld = value;
      });
      setState(() {});
    });
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
      body: Stack(
        children: [
          Positioned(
            top: -300,
            right: 10,
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: app_theme.primary_color,
                      minRadius: 80,
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 150, sigmaY: 150),
                      child: Container(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                )),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                  child: AppBar(
                    elevation: 0,
                    actions: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.settings_outlined,
                            color: Colors.white,
                          ))
                    ],
                    backgroundColor: Colors.transparent,
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
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 240,
                  child: LineChart(
                    LineChartData(
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: leftTitleWidgets,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 20,
                            getTitlesWidget: bottomwidget,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          color: app_theme.primary_color,
                          isCurved: true,
                          isStrokeCapRound: true,
                          barWidth: 3,
                          spots: cld
                              .map((point) =>
                                  FlSpot(point["day"], point["value"]))
                              .toList(),
                          dotData: FlDotData(
                            show: false,
                          ),
                        ),
                      ],
                    ),
                    swapAnimationDuration: Duration(milliseconds: 150),
                    swapAnimationCurve: Curves.bounceIn,
                    // Optional
                  ),
                ),
                Container(
                  child: wl_loading == false
                      ? Obx(() => ListView.builder(
                            itemCount: gwl.watch_list.length,
                            padding: EdgeInsets.only(top: 30),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Dismissible(
                                key: Key(gwl.watch_list[index].token!),
                                onDismissed: (direction) {
                                  // Remove the item from the data source.
                                  setState(() {
                                    gwl.watch_list.removeAt(index);
                                    gwl.save_watchlist();
                                  });
                                },
                                background: Container(
                                  color: Colors.red,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                child: Container(
                                  color: Colors.black,
                                  child: ListTile(
                                    onTap: () async {
                                      fd
                                          .get_ltp(
                                              gwl.watch_list[index].symbol!,
                                              gwl.watch_list[index].token!,
                                              gwl.watch_list[index].exchSeg!)
                                          .then((value) {
                                        Get.to(() => stock_info(
                                              data: stock_info_model(
                                                name:
                                                    gwl.watch_list[index].name,
                                                exchange: gwl
                                                    .watch_list[index].exchSeg,
                                                tradingsymbol: gwl
                                                    .watch_list[index].symbol,
                                                stock_id: int.parse(gwl
                                                    .watch_list[index].token!),
                                                symboltoken: gwl
                                                    .watch_list[index].token!,
                                                open: "0",
                                                high: "0",
                                                low: "0",
                                                close: value,
                                              ),
                                            ));
                                      });
                                    },
                                    title: Text(
                                      gwl.watch_list[index].name!,
                                      style: app_theme.ts_price,
                                    ),
                                    trailing: SizedBox(
                                      width: 200,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: FutureBuilder<List<double>>(
                                                future: fd.minichart_data(
                                                    gwl.watch_list[index]
                                                        .exchSeg!,
                                                    gwl.watch_list[index]
                                                        .token!),
                                                initialData: [
                                                  0.0,
                                                  0.0,
                                                  0.0,
                                                  0.0
                                                ],
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<List<double>>
                                                        snapshot) {
                                                  if (snapshot.hasError) {
                                                    return Center(
                                                      child: Text(
                                                        '${snapshot.error} occured',
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    );
                                                  } else if (snapshot.hasData) {
                                                    return Sparkline(
                                                      data: snapshot.data!,
                                                      useCubicSmoothing: true,
                                                      cubicSmoothingFactor: 0.2,
                                                      lineWidth: 5.0,
                                                      lineColor: app_theme
                                                          .primary_color
                                                          .shade500,
                                                    );
                                                  } else {
                                                    return SizedBox(
                                                      width: 20,
                                                      height: 50,
                                                    );
                                                  }
                                                }),
                                          ),
                                          FutureBuilder(
                                            future: fd.get_ltp(
                                                gwl.watch_list[index].symbol!,
                                                gwl.watch_list[index].token!,
                                                gwl.watch_list[index].exchSeg!),
                                            initialData: "0.0",
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String>
                                                    snapshot) {
                                              return Text(
                                                "₹" + snapshot.data.toString(),
                                                style: app_theme.ts_price,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    subtitle: Text(
                                      gwl.watch_list[index].token.toString(),
                                      style: app_theme.ts_qyt,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ))
                      : Center(
                          child: CircularProgressIndicator(
                          color: app_theme.primary_color,
                        )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
