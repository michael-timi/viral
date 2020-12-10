import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:viral/models/testimony.dart';
import 'expanded_content_widget.dart';
import 'image_widget.dart';

class LocationWidget extends StatefulWidget {
  final Testimony testimony;

  const LocationWidget({
    @required this.testimony,
    Key key,
  }) : super(key: key);

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 40 : 200,
            width: isExpanded ? size.width * 0.78 : size.width * 0.7,
            height: isExpanded ? size.height * 0.6 : size.height * 0.5,
            child: ExpandedContentWidget(testimony: widget.testimony),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 230 : 200,
            child: GestureDetector(
              onPanUpdate: onPanUpdate,
              onTap: () {},
              child: ImageWidget(testimony: widget.testimony),
            ),
          ),
        ],
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }
}
