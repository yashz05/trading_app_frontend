import 'package:flutter/material.dart';
import 'package:trading_app_hackathon/configs/theme.dart';

class home_innerlist extends StatefulWidget {
  const home_innerlist({Key? key}) : super(key: key);

  @override
  State<home_innerlist> createState() => _home_innerlistState();
}

class _home_innerlistState extends State<home_innerlist>
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: app_theme.primary_color,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                Container(
                  child: ListView.builder(
                    itemCount: 100,
                    padding: EdgeInsets.only(top: 100),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Colors.black,
                        child: ListTile(
                          title: Text(
                            "Adani ENT",
                            style: app_theme.ts_price,
                          ),
                          trailing: Text(
                            ((index + 1) * 10).toString(),
                            style: app_theme.ts_price,
                          ),
                          subtitle: Text(
                            (index + 1).toString() + " qyt",
                            style: app_theme.ts_qyt,
                          ),
                        ),
                      );
                    },
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
