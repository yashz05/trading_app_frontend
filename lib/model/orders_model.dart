class orders_model {
  String? uid;
  String? token;
  String? name;
  double? buyRate;
  bool? position;
  double? sellRate;
  int? qty;
  String? orderId;

  orders_model(
      {this.uid,
        this.token,
        this.name,
        this.buyRate,
        this.position,
        this.sellRate,
        this.qty,
        this.orderId});

  orders_model.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    token = json['token'];
    name = json['name'];
    buyRate = json['buy_rate'];
    position = json['position'];
    sellRate = json['sell_rate'];
    qty = json['qty'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['token'] = this.token;
    data['name'] = this.name;
    data['buy_rate'] = this.buyRate;
    data['position'] = this.position;
    data['sell_rate'] = this.sellRate;
    data['qty'] = this.qty;
    data['order_id'] = this.orderId;
    return data;
  }
}
