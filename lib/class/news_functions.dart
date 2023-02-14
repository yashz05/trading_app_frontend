import 'dart:convert';

import 'package:get/get.dart';
import 'package:trading_app_hackathon/configs/news_api.dart';
import 'package:http/http.dart' as http;
import 'package:trading_app_hackathon/model/news_feed.dart';
import 'package:xml2json/xml2json.dart';

class news_functions extends GetxController {
  RxList<news_feed> top_news = <news_feed>[].obs;

  void get_top_news(String query) async {
    //creating Object
    final Xml2Json xml2Json = Xml2Json();
    var rss_feed = await http
        .get(Uri.parse(news_api.news_feed_api + query + "&output=rss"));
    // we are receiving feed in rss from google lets convert
    xml2Json.parse(rss_feed.body);
    var jsonconverted = xml2Json.toParker();
    // data["rss"]["channel"]["items"] as per rss feed
    List<news_feed> list =
        (json.decode(jsonconverted)["rss"]["channel"]["item"] as List)
            .map((data) => news_feed.fromJson(data))
            .toList();
    if (top_news.isNotEmpty) {
      top_news.clear();
    }
    top_news.addAll(list);
  }

  Future<List<news_feed>> search_news(String query) async {
    //creating Object
    final Xml2Json xml2Json = Xml2Json();
    var news_feed_rss = await http
        .get(Uri.parse(news_api.news_feed_api + query + "&output=rss"));
    xml2Json.parse(news_feed_rss.body);
    var news_rss_json = xml2Json.toParker();
    List<news_feed> list =
        (json.decode(news_rss_json)["rss"]["channel"]["item"] as List)
            .map((data) => news_feed.fromJson(data))
            .toList();
    return list;
  }
}
