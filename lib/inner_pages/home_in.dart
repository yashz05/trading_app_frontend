import 'dart:math';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import "package:mrx_charts/mrx_charts.dart";
import 'package:chart_sparkline/chart_sparkline.dart';

class home_innerlist extends StatefulWidget {
  const home_innerlist({Key? key}) : super(key: key);

  @override
  State<home_innerlist> createState() => _home_innerlistState();
}

class _home_innerlistState extends State<home_innerlist>
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: app_theme.primary_color,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                  child: ListView.builder(
                    itemCount: 100,
                    padding: EdgeInsets.only(top: 30),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Colors.black,
                        child: ListTile(
                          title: Text(
                            "Adani ENT",
                            style: app_theme.ts_price,
                          ),
                          trailing: SizedBox(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Sparkline(
                                    data: [
                                      0.0,
                                      1.0,
                                      1.5,
                                      2.0,
                                      0.0,
                                      0.0,
                                      -0.5,
                                      -1.0,
                                      -0.5,
                                      0.0,
                                      0.0
                                    ],
                                    lineWidth: 5.0,
                                    lineColor: app_theme.primary_color.shade500,
                                  ),
                                ),
                                Text(
                                  ((index + 1) * 10).toString(),
                                  style: app_theme.ts_price,
                                ),
                              ],
                            ),
                          ),
                          subtitle: Text(
                            (index + 1).toString() + " qyt",
                            style: app_theme.ts_qyt,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
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
