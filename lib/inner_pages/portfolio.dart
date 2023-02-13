import 'package:flutter/material.dart';

class portfolio extends StatefulWidget {
  const portfolio({Key? key}) : super(key: key);

  @override
  State<portfolio> createState() => _portfolioState();
}

class _portfolioState extends State<portfolio> with SingleTickerProviderStateMixin {
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
    return const Placeholder();
  }
}
