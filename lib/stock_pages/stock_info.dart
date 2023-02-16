import 'dart:math';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/class/finance_data.dart';
import 'package:trading_app_hackathon/class/news_functions.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import "package:mrx_charts/mrx_charts.dart";
import 'package:trading_app_hackathon/extra/stock_info_inner_page.dart';
import 'package:trading_app_hackathon/model/ltp_quote.dart';
import 'package:trading_app_hackathon/model/news_feed.dart';
import 'package:get/get.dart';
import 'package:trading_app_hackathon/model/stock_info_model.dart';
import 'package:trading_app_hackathon/widgets/news_tile.dart';

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
                    child: Chart(layers: layers()),
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
