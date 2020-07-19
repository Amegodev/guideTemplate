import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreeState createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Hello Home Screen!'),
      ),
    );
  }
}
