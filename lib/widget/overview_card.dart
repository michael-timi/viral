import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class OverviewCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String number;
  final List<Color> color;

  OverviewCard({
    Key key,
    this.icon,
    this.title,
    this.number,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(8.0),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: color),
        ),
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: white,
              size: 25,
            ),
            SizedBox(height: 5),
            AutoSizeText(
              title,
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 10),
              maxLines: 1,
            ),
            SizedBox(height: 5),
            AutoSizeText(
              number,
              style: TextStyle(fontSize: 20, color: white),
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}
