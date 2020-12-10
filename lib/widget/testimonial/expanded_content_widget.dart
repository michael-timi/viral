import 'package:flutter/material.dart';
import 'package:viral/models/testimony.dart';
import 'stars_widget.dart';

class ExpandedContentWidget extends StatelessWidget {
  final Testimony testimony;

  const ExpandedContentWidget({
    @required this.testimony,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(testimony.testimony),
            SizedBox(height: 8),
            buildAddressRating(testimony: testimony),
            SizedBox(height: 12),
            //buildReview(location: location)
          ],
        ),
      );

  Widget buildAddressRating({
    @required Testimony testimony,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            testimony.company,
            style: TextStyle(color: Colors.black45),
          ),
          StarsWidget(stars: testimony.starRating),
        ],
      );
}
