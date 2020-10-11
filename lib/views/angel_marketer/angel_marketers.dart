import 'package:flutter/material.dart';

class AngelMarketers extends StatefulWidget {
  final AngelMarketers angelMarketers;

  AngelMarketers({Key key, this.angelMarketers}) : super(key: key);
  @override
  _AngelMarketersState createState() => _AngelMarketersState();
}

class _AngelMarketersState extends State<AngelMarketers> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[],
        ),
      ),
    );
  }
}
