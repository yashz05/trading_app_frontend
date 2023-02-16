import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/class/finance_data.dart';
import 'package:trading_app_hackathon/class/news_functions.dart';
import 'package:trading_app_hackathon/class/watchlist.dart';
import 'package:trading_app_hackathon/configs/backend_api.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import 'package:get/get.dart';
import 'package:trading_app_hackathon/model/ltp_quote.dart';
import 'package:trading_app_hackathon/model/search_model.dart';
import 'package:trading_app_hackathon/widgets/news_tile.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  news_functions nf = Get.put(news_functions());
  watch_lsit wl = Get.put(watch_lsit());

  TextEditingController search = TextEditingController();
  var channel =
      WebSocketChannel.connect(Uri.parse(backend_api.search_api_websocket));
  List<search_model> sl = [];


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    nf.get_top_news("Indian Stock Marker");
    channel.stream.listen(
      (data) {
        var stock_list = jsonDecode(data);
        List<search_model> new_sl = (json.decode(data) as List)
            .map((data) => search_model.fromJson(data))
            .toList();
        setState(() {
          sl = new_sl;
        });
      },
      onError: (error) => print(error),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined))
          ],
          backgroundColor: Colors.black,
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
        body: Stack(children: [
          Container(
              margin: EdgeInsets.only(bottom: 150),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: null),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: search,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  onSubmitted: (n) {
                    search_stock();
                  },
                  decoration: InputDecoration(
                      filled: true,
                      icon: Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.white,
                      ),
                      fillColor: Colors.white12,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      )),
                ),
                search.text.isEmpty
                    ? Obx(() => nf.top_news != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 25.0, top: 10),
                                child: Text(
                                  "Top Stories",
                                  style: app_theme.ts_name,
                                ),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: nf.top_news.length,
                                  itemBuilder: (BuildContext ctx, int i) {
                                    return Container(
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      color: Colors.black,
                                      child: news_tile(
                                        title: nf.top_news[i].title!,
                                        link: nf.top_news[i].link!,
                                        date: nf.top_news[i].pubDate!,
                                      ),
                                    );
                                  }),
                            ],
                          )
                        : SizedBox())
                    : sl != null
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: sl.length,
                            itemBuilder: (BuildContext ctx, int i) {
                              return Container(
                                color: Colors.black,
                                child: ListTile(
                                  onTap: () {
                                    wl.ad_to_watch_list(sl[i]);
                                    wl.get_watch_list();
                                  },
                                  title: Text(
                                    sl[i].name!,
                                    style: app_theme.ts_name,
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(sl[i].symbol!,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.normal)),
                                      Text(
                                        sl[i].exchSeg! + " " + sl[i].expiry!,
                                        style: app_theme.ts_qyt,
                                      ),
                                    ],
                                  ),
                                  trailing: Icon(
                                    Icons.add,
                                    color: app_theme.primary_color,
                                  ),
                                ),
                              );
                            })
                        : Center(
                            child: CircularProgressIndicator(
                              color: app_theme.primary_color,
                            ),
                          )
              ],
            ),
          )
        ]));
  }

  search_stock() {
    if (search.text.isNotEmpty) {
      channel.sink.add(search.text.toUpperCase());
    }
    setState(() {});
  }

  add_to_watch_list() {}
}
