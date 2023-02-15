import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/auth/index.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import 'package:trading_app_hackathon/pages/home.dart';
import 'package:get/get.dart';
void main() {
  runApp(const GetMaterialApp(home: MyApp(),debugShowCheckedModeBanner: false,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Unigo Trading App',
        theme: ThemeData(
          primarySwatch: app_theme.primary_color,
        ),
        home: index());
  }
}
