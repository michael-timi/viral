import 'package:flutter/material.dart';
import 'package:viral/models/testimonial.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/testimonial/locations_widget.dart';
import 'package:viral/widget/title.dart';

class Testimonials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          title: CustomText(
            text: 'TESTIMONIALS',
            size: 12,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          centerTitle: true),
      body: LocationsWidget(),
    );
  }
}
