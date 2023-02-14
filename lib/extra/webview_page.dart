import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webview_page extends StatefulWidget {
  final String url;
  final String title;

  const webview_page({Key? key, required this.url , required this.title}) : super(key: key);

  @override
  State<webview_page> createState() => _webview_pageState();
}

class _webview_pageState extends State<webview_page>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    setState(() {
      controller = WebViewController()
        ..loadRequest(
          Uri.parse(widget.url),
        );
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
      appBar: AppBar(
        title: Text(widget.title,style: app_theme.ts_price,),
        backgroundColor: Colors.black,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
