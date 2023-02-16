import 'dart:math';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/class/finance_data.dart';
import 'package:trading_app_hackathon/configs/angel_endpoints.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import "package:mrx_charts/mrx_charts.dart";
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:get/get.dart';
import 'package:trading_app_hackathon/model/stock_info_model.dart';
import 'package:trading_app_hackathon/stock_pages/stock_info.dart';
import 'package:trading_app_hackathon/class/watchlist.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    gwl.get_watch_list().then((value) {
      setState(() {
        wl_loading = !wl_loading;
      });
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
                  child: Chart(layers: layers()),
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
                                    onTap: () {
                                      Get.to(() => stock_info(
                                            data: stock_info_model(
                                              name: "ADANI ENTERPRISE",
                                              exchange: "NSE",
                                              tradingsymbol: "ADANI_ENT",
                                              stock_id: 1234,
                                              symboltoken: "ADANI",
                                              open: "100",
                                              high: "150",
                                              low: "80",
                                              close: "102",
                                            ),
                                          ));
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

  //get real time stock update
  void get_realtime() async {}

  List<ChartLayer> layers() {
    final from = DateTime(2021, 4);
    final to = DateTime(2021, 8);
    final frequency =
        (to.millisecondsSinceEpoch - from.millisecondsSinceEpoch) / 3.0;
    return [
      ChartHighlightLayer(
        shape: () => ChartHighlightLineShape<ChartLineDataItem>(
          backgroundColor: app_theme.primary_color.shade900,
          currentPos: (item) => item.currentValuePos,
          radius: const BorderRadius.all(Radius.circular(8.0)),
          width: 60.0,
        ),
      ),
      ChartAxisLayer(
        settings: ChartAxisSettings(
          x: ChartAxisSettingsAxis(
            frequency: frequency,
            max: to.millisecondsSinceEpoch.toDouble(),
            min: from.millisecondsSinceEpoch.toDouble(),
            textStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 10.0,
            ),
          ),
          y: ChartAxisSettingsAxis(
            frequency: 100.0,
            max: 400.0,
            min: 0.0,
            textStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 10.0,
            ),
          ),
        ),
        labelX: (value) => DateFormat('MMM')
            .format(DateTime.fromMillisecondsSinceEpoch(value.toInt())),
        labelY: (value) => value.toInt().toString(),
      ),
      ChartLineLayer(
        items: List.generate(
          4,
          (index) => ChartLineDataItem(
            x: (index * frequency) + from.millisecondsSinceEpoch,
            value: Random().nextInt(380) + 20,
          ),
        ),
        settings: ChartLineSettings(
          color: app_theme.primary_color,
          thickness: 4.0,
        ),
      ),
      ChartTooltipLayer(
        shape: () => ChartTooltipLineShape<ChartLineDataItem>(
          backgroundColor: Colors.white,
          circleBackgroundColor: Colors.white,
          circleBorderColor: app_theme.primary_color,
          circleSize: 4.0,
          circleBorderThickness: 2.0,
          currentPos: (item) => item.currentValuePos,
          onTextValue: (item) => '€${item.value.toString()}',
          marginBottom: 6.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          radius: 6.0,
          textStyle: TextStyle(
            color: app_theme.primary_color,
            letterSpacing: 0.2,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ];
  }
}
