import 'package:flutter/material.dart';
import 'package:viral/models/updates_and_offers_library.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/title.dart';

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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      CustomText(
                        text: updates_and_offers[index].title,
                        fontWeight: FontWeight.bold,
                        size: 17,
                      ),
                      SizedBox(height: 2),
                      CustomText(
                          text: updates_and_offers[index].time,
                          color: grey,
                          size: 10),
                      SizedBox(height: 10),
                    ],
                  ),
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
      appBar: AppBar(
        title: CustomText(
          text: update.title,
          size: 12,
          color: white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  update.imgUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 15),
              CustomText(
                text: update.title,
                size: 17,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 2),
              CustomText(
                text: update.time,
                color: grey,
                size: 10,
              ),
              SizedBox(height: 4),
              CustomText(text: update.body, size: 14)
            ],
          ),
        ),
      ),
    );
  }
}
