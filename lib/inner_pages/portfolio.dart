import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/configs/theme.dart';

class portfolio_innerlist extends StatefulWidget {
  const portfolio_innerlist({Key? key}) : super(key: key);

  @override
  State<portfolio_innerlist> createState() => _portfolio_innerlistState();
}

class _portfolio_innerlistState extends State<portfolio_innerlist>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
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
      body: Stack(
        children: [
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hello, Yash",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(13),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                        colors: [
                          Color(0xffbdd9eb),
                          Color(0xfffce4c0),
                          Color(0xfff479af),
                        ],
                        begin: const FractionalOffset(-0.5, 1),
                        end: const FractionalOffset(1.6, -1),
                        stops: [0.3, 0.4, 0.8],
                        tileMode: TileMode.clamp),
                  ),
                  child: Text(
                    'Current Balance',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: app_theme.primary_color,
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Deposit",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: OutlinedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Withdraw",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        onPressed: () {
                          print("it's pressed");
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                              width: 2.0, color: app_theme.primary_color),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.black,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: Text(
                          "Adani ENT",
                          style: app_theme.ts_price,
                        ),
                        trailing: Text(
                          "10",
                          style: app_theme.ts_price,
                        ),
                        subtitle: Text(
                          "10 qyt",
                          style: app_theme.ts_qyt,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Adani ENT",
                          style: app_theme.ts_price,
                        ),
                        trailing: Text(
                          "10",
                          style: app_theme.ts_price,
                        ),
                        subtitle: Text(
                          "10 qyt",
                          style: app_theme.ts_qyt,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Adani ENT",
                          style: app_theme.ts_price,
                        ),
                        trailing: Text(
                          "10",
                          style: app_theme.ts_price,
                        ),
                        subtitle: Text(
                          "10 qyt",
                          style: app_theme.ts_qyt,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Adani ENT",
                          style: app_theme.ts_price,
                        ),
                        trailing: Text(
                          "10",
                          style: app_theme.ts_price,
                        ),
                        subtitle: Text(
                          "10 qyt",
                          style: app_theme.ts_qyt,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Adani ENT",
                          style: app_theme.ts_price,
                        ),
                        trailing: Text(
                          "10",
                          style: app_theme.ts_price,
                        ),
                        subtitle: Text(
                          "10 qyt",
                          style: app_theme.ts_qyt,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Adani ENT",
                          style: app_theme.ts_price,
                        ),
                        trailing: Text(
                          "10",
                          style: app_theme.ts_price,
                        ),
                        subtitle: Text(
                          "10 qyt",
                          style: app_theme.ts_qyt,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Adani ENT",
                          style: app_theme.ts_price,
                        ),
                        trailing: Text(
                          "10",
                          style: app_theme.ts_price,
                        ),
                        subtitle: Text(
                          "10 qyt",
                          style: app_theme.ts_qyt,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Adani ENT",
                          style: app_theme.ts_price,
                        ),
                        trailing: Text(
                          "10",
                          style: app_theme.ts_price,
                        ),
                        subtitle: Text(
                          "10 qyt",
                          style: app_theme.ts_qyt,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Adani ENT",
                          style: app_theme.ts_price,
                        ),
                        trailing: Text(
                          "10",
                          style: app_theme.ts_price,
                        ),
                        subtitle: Text(
                          "10 qyt",
                          style: app_theme.ts_qyt,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Adani ENT",
                          style: app_theme.ts_price,
                        ),
                        trailing: Text(
                          "10",
                          style: app_theme.ts_price,
                        ),
                        subtitle: Text(
                          "10 qyt",
                          style: app_theme.ts_qyt,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Adani ENT",
                          style: app_theme.ts_price,
                        ),
                        trailing: Text(
                          "10",
                          style: app_theme.ts_price,
                        ),
                        subtitle: Text(
                          "10 qyt",
                          style: app_theme.ts_qyt,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Adani ENT",
                          style: app_theme.ts_price,
                        ),
                        trailing: Text(
                          "10",
                          style: app_theme.ts_price,
                        ),
                        subtitle: Text(
                          "10 qyt",
                          style: app_theme.ts_qyt,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Adani ENT",
                          style: app_theme.ts_price,
                        ),
                        trailing: Text(
                          "10",
                          style: app_theme.ts_price,
                        ),
                        subtitle: Text(
                          "10 qyt",
                          style: app_theme.ts_qyt,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Adani ENT",
                          style: app_theme.ts_price,
                        ),
                        trailing: Text(
                          "10",
                          style: app_theme.ts_price,
                        ),
                        subtitle: Text(
                          "10 qyt",
                          style: app_theme.ts_qyt,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Adani ENT",
                          style: app_theme.ts_price,
                        ),
                        trailing: Text(
                          "10",
                          style: app_theme.ts_price,
                        ),
                        subtitle: Text(
                          "10 qyt",
                          style: app_theme.ts_qyt,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
