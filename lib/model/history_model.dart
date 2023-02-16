import 'dart:convert';

HistoryModel historyModelFromJson(String str) =>
    HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
  HistoryModel({
    required this.status,
    required this.message,
    required this.errorcode,
    required this.data,
  });

  bool status;
  String message;
  String errorcode;
  List<List<dynamic>> data;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        status: json["status"],
        message: json["message"],
        errorcode: json["errorcode"],
        data: List<List<dynamic>>.from(
            json["data"].map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "errorcode": errorcode,
        "data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
