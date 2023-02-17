import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/class/finance_data.dart';
import 'package:trading_app_hackathon/class/news_functions.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import 'package:trading_app_hackathon/extra/detail_chart.dart';
import 'package:trading_app_hackathon/extra/stock_info_inner_page.dart';
import 'package:trading_app_hackathon/model/news_feed.dart';
import 'package:get/get.dart';
import 'package:trading_app_hackathon/model/stock_info_model.dart';
import 'package:trading_app_hackathon/widgets/news_tile.dart';
import 'package:fl_chart/fl_chart.dart';

class stock_info extends StatefulWidget {
  final stock_info_model data;

  const stock_info({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<stock_info> createState() => _stock_infoState();
}

class _stock_infoState extends State<stock_info>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  news_functions nf = Get.put(news_functions());
  List<news_feed> nfl = [];

  finance_data fd = Get.put(finance_data());
  stock_info_model ltp = stock_info_model();
  List cld = [];

  //SAME WIDGET FROM HOME
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
    nf.search_news(widget.data.name!).then((value) {
      setState(() {
        nfl = value;
      });
    });
    fd
        .quick_view_chart(widget.data.exchange!, widget.data.symboltoken!)
        .then((value) {
      setState(() {
        cld = value;
      });
    });
    fd
        .ohlc(widget.data.tradingsymbol!, widget.data.symboltoken!,
            widget.data.exchange!)
        .then((value) {

      setState(() {
        ltp = stock_info_model(
          name: widget.data.name,
          exchange: widget.data.exchange,
          tradingsymbol: widget.data.tradingsymbol,
          symboltoken: widget.data.symboltoken,
          open: value.data!.open.toString(),
          high: value.data!.high.toString(),
          low: value.data!.low.toString(),
          close: value.data!.close.toString(),
        );
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                        actions: [
                          GestureDetector(
                            onTap: () {
                              Get.to(detail_chart(
                                  name: widget.data.name!,
                                  exch: widget.data.exchange!,
                                  token: widget.data.symboltoken!));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.0, right: 20),
                              child: Text(
                                "View Chart",
                                style: app_theme.ts_name,
                              ),
                            ),
                          )
                        ],
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        leading: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_left_outlined,
                            color: app_theme.primary_color,
                            size: 40,
                          ),
                        )),
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
                  TabBar(
                    labelColor: app_theme.primary_color,
                    indicatorColor: app_theme.primary_color,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.bookmark_border),
                        text: "Information",
                      ),
                      Tab(
                        icon: Icon(Icons.newspaper),
                        text: "News",
                      ),
                    ],
                  ),
                  // TabBar
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.80,
                    child: TabBarView(
                      children: [
                        stock_info_inner(data: ltp),
                        nfl != null
                            ? ListView.builder(
                                itemCount: nfl.length,
                                itemBuilder: (BuildContext ctx, int i) {
                                  return news_tile(
                                    title: nfl[i].title!,
                                    link: nfl[i].link!,
                                    date: nfl[i].pubDate!,
                                  );
                                })
                            : SizedBox(),
                      ],
                    ),
                  ), // TabBar
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//REMOVED BECAUSE CHARTS TO HEAVY
}
