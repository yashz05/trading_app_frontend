import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/configs/theme.dart';
import 'package:trading_app_hackathon/model/stock_info_model.dart';

class stock_info_inner extends StatelessWidget {
  final stock_info_model data;

  const stock_info_inner({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child:data.name != null ? Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  textAlign: TextAlign.end,
                  style: app_theme.stock__info_tags,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  data.name!,
                  textAlign: TextAlign.end,
                  style: app_theme.ts_name,
                )
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Listed ",
                  textAlign: TextAlign.end,
                  style: app_theme.stock__info_tags,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  data.exchange!,
                  textAlign: TextAlign.end,
                  style: app_theme.ts_name,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Open",
                  textAlign: TextAlign.end,
                  style: app_theme.stock__info_tags,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  data.open!,
                  textAlign: TextAlign.end,
                  style: app_theme.ts_name,
                )
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "High ",
                  textAlign: TextAlign.end,
                  style: app_theme.stock__info_tags,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  data.high!,
                  textAlign: TextAlign.end,
                  style: app_theme.ts_name,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Low",
                  textAlign: TextAlign.end,
                  style: app_theme.stock__info_tags,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  data.low!,
                  textAlign: TextAlign.end,
                  style: app_theme.ts_name,
                )
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300,
                  child: Text(
                    "LTP ",
                    textAlign: TextAlign.end,
                    style: app_theme.stock__info_tags,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    "1500000",
                    textAlign: TextAlign.end,
                    style: app_theme.ts_name,
                  ),
                )
              ],
            ),
          )
        ],
      ) : SizedBox(
        height: 10,
          width: 10,

          child: Text("Loading",style: app_theme.ts_name,)),
    );
  }
}
