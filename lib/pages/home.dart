import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/class/finance_data.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import 'package:trading_app_hackathon/inner_pages/home_in.dart';
import 'package:trading_app_hackathon/inner_pages/portfolio.dart';
import 'package:trading_app_hackathon/inner_pages/search.dart';
import 'package:trading_app_hackathon/inner_pages/orders.dart';
import 'package:get/get.dart';


class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int current_page = 0;
  finance_data fd = Get.put(finance_data());

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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: app_theme.primary_color,
        currentIndex: current_page,
        onTap: (n) {
          setState(() {
            current_page = n;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outline_rounded), label: "Portfolio"),
          BottomNavigationBarItem(
              icon: Icon(Icons.cases_outlined), label: "Orders"),
        ],
      ),
      body: IndexedStack(
        index: current_page,
        children: [
          home_innerlist(),
          search(),
          portfolio_innerlist(),
          orders_page()
        ],
      ),
    );
  }


}
