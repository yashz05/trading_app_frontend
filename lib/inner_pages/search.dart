import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/class/news_functions.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import 'package:get/get.dart';
import 'package:trading_app_hackathon/extra/webview_page.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  news_functions nf = Get.put(news_functions());
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    nf.get_top_news("Indian Stock Marker");
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
                  style: TextStyle(fontSize: 20, color: Colors.white),
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
                                  itemBuilder: (BuildContext ctx, i) {
                                    return Container(
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      color: Colors.black,
                                      child: ListTile(
                                        onTap: () {
                                          Get.to(webview_page(
                                              url: nf.top_news[i].link!,title:nf.top_news[i].title! ,));
                                        },
                                        title: Text(
                                          nf.top_news[i].title
                                              .toString()
                                              .replaceAll(";", "."),
                                          style: app_theme.ts_name,
                                        ),
                                        subtitle: Text(
                                          "\n" +
                                              nf.top_news[i].pubDate.toString(),
                                          style: app_theme.ts_qyt,
                                        ),
                                        trailing: Icon(
                                          Icons.chevron_right_rounded,
                                          color: app_theme.primary_color,
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          )
                        : SizedBox())
                    : SizedBox(),
              ],
            ),
          )
        ]));
  }
}
