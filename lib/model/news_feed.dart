class news_feed {
  String? title;
  String? link;
  String? guid;
  String? pubDate;

  String? source;

  news_feed(
      {this.title,
        this.link,
        this.guid,
        this.pubDate,
        this.source});

  news_feed.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    guid = json['guid'];
    pubDate = json['pubDate'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['link'] = this.link;
    data['guid'] = this.guid;
    data['pubDate'] = this.pubDate;

    data['source'] = this.source;
    return data;
  }
}

class Description {
  Ol? ol;

  Description({this.ol});

  Description.fromJson(Map<String, dynamic> json) {
    ol = json['ol'] != null ? new Ol.fromJson(json['ol']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ol != null) {
      data['ol'] = this.ol!.toJson();
    }
    return data;
  }
}

class Ol {
  List<Li>? li;

  Ol({this.li});

  Ol.fromJson(Map<String, dynamic> json) {
    if (json['li'] != null) {
      li = <Li>[];
      json['li'].forEach((v) {
        li!.add(new Li.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.li != null) {
      data['li'] = this.li!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Li {
  String? text;
  String? a;
  String? font;

  Li({this.text, this.a, this.font});

  Li.fromJson(Map<String, dynamic> json) {
    text = json['#text'];
    a = json['a'];
    font = json['font'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['#text'] = this.text;
    data['a'] = this.a;
    data['font'] = this.font;
    return data;
  }
}
