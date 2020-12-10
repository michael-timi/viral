import 'package:flutter/material.dart';
import 'package:viral/models/testimony.dart';

class LatLongWidget extends StatelessWidget {
  final Testimony testimony;

  const LatLongWidget({
    @required this.testimony,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            testimony.city,
            style: TextStyle(color: Colors.white70),
          ),
          Icon(Icons.location_on, color: Colors.white70),
          Text(
            testimony.state,
            style: TextStyle(color: Colors.white70),
          )
        ],
      );
}
