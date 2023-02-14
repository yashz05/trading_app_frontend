import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trading_app_hackathon/extra/webview_page.dart';
import 'package:trading_app_hackathon/configs/theme.dart';

class news_tile extends StatelessWidget {
  final String link;

  final String title;
  final String date;

  const news_tile(
      {Key? key, required this.title, required this.link, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(webview_page(
          url: link,
          title: title,
        ));
      },
      title: Text(
        title.toString().replaceAll(";", "."),
        style: app_theme.ts_name,
      ),
      subtitle: Text(
        "\n" + date.toString(),
        style: app_theme.ts_qyt,
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: app_theme.primary_color,
      ),
    );
  }
}
