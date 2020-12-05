import 'package:flutter/material.dart';
import 'package:viral/models/updates_and_offers_library.dart';
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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, left: 8.0, right: 8.0, bottom: 12.0),
        child: ListView.builder(
            itemCount: updates_and_offers.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          update: updates_and_offers[index],
                        ),
                      ));
                },
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      //color: white,
                      child: Image.asset(
                        updates_and_offers[index].imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: updates_and_offers[index].title,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              );
            }),
      )),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final UpdateAndOfferslibrary update;

  DetailsPage({Key key, this.update}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomText(
              text: update.body,
            )
          ],
        ),
      ),
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
