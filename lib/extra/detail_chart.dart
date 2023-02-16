import 'package:flutter/material.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:trading_app_hackathon/class/finance_data.dart';
import 'package:get/get.dart';
import 'package:trading_app_hackathon/configs/theme.dart';

class detail_chart extends StatefulWidget {
  final String exch;
  final String token;
  final String name;

  const detail_chart({Key? key, required this.exch, required this.token, required this.name})
      : super(key: key);

  @override
  State<detail_chart> createState() => _detail_chartState();
}

class _detail_chartState extends State<detail_chart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  finance_data fd = Get.put(finance_data());
  List<Candle> candles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    fd.candle_stick_data(widget.exch, widget.token).then((value) {
      print(value);
      List<Candle> cdl = value.map((e) => Candle.fromJson(e)).toList();
      setState(() {
        candles = cdl;
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
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.name,style: app_theme.ts_name,),
        backgroundColor: Colors.black,
      ),
      body: Theme(
        data: ThemeData(brightness: Brightness.dark),
        child: Candlesticks(
          candles: candles,
        ),
      ),
    );
  }
}
