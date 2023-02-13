import 'package:flutter/material.dart';

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
      appBar: AppBar(),
    );
  }
}
