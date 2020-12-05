import 'package:flutter/material.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/title.dart';

//update and offer news
class UpdateAndOffers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: CustomText(
          text: 'UPDATES AND OFFERS',
          size: 12,
          color: white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: Container()),
    );
  }
}

//testimonials news
class Testimonials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: CustomText(
          text: 'TESTIMONIALS',
          size: 12,
          color: white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: Container()),
    );
  }
}

//FAQS news
class FAQS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: CustomText(
          text: 'FAQS',
          size: 12,
          color: white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: Container()),
    );
  }
}
