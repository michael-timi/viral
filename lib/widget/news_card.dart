import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class NewsWidget extends StatelessWidget {
  final String title;
  final Function onPress;
  final IconData icon;

  const NewsWidget({
    Key key,
    this.title,
    this.icon, this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: white,
            ),
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: AutoSizeText(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        color: black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        icon,
                        color: black,
                        size: 25,
                      ),
                      onPressed: onPress)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
