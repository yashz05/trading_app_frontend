class stock_info_model {
  //api data
  // "exchange":"NSE",
  // "tradingsymbol":"SBIN-EQ",
  // "symboltoken":"3045",
  // "open":"186",
  // "high":"191.25",
  // "low":"185",
  // "close":"187.80",
  // "ltp":"191",
  String? name ;
  String? exchange;
  String? tradingsymbol;
  String? symboltoken;
  String? open;
  String? high;
  String? low;
  String? close;
  String? ltp;
  int? stock_id;

  stock_info_model(
      {this.name,
        this.exchange,
      this.tradingsymbol,
      this.symboltoken,
      this.open,
      this.high,
      this.low,
      this.close,
      this.stock_id});
}
