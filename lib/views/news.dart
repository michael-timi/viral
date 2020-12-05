import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viral/models/testimonial.dart';
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
                      size: 20,
                    ),
                    SizedBox(height: 2),
                    CustomText(
                        text: updates_and_offers[index].time,
                        color: grey,
                        size: 12),
                    SizedBox(height: 10),
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
                size: 20,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 2),
              CustomText(
                text: update.time,
                color: grey,
                size: 12,
              ),
              SizedBox(height: 4),
              CustomText(
                text: update.body,
              )
            ],
          ),
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
      body: SafeArea(
          child: Container(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: testimonial.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            child: CircleAvatar(
                              foregroundColor:
                                  Theme.of(context).backgroundColor,
                              radius: 20,
                              backgroundImage:
                                  AssetImage(testimonial[index].imgUrl),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: testimonial[index].testimony),
                                SizedBox(height: 5),
                                CustomText(
                                  text: testimonial[index].name,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(height: 5),
                                CustomText(
                                  text: testimonial[index].company,
                                  color: grey,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  );
                })),
      )),
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
      body: SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: '\nHow Does Viral Work',
                size: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                  text:
                      '\nYou create a campaign (first is free) and we promote it to WhatsApp audience that you can afford.'),
              CustomText(
                text: '\nHow Do I Track Ad Performance',
                size: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                  text:
                      '\nYou can convert your link to bit.ly and see the click count and other analytics on your bit.ly dashboard.'),
              CustomText(
                text: '\nWhat Do You Recommend for Effective Results',
                size: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                  text:
                      '\nIf you can afford it, we strongly recommend you design a good sales funnel. Use motion graphics instead of graphics or video with a nice gbedu song as back ground music. Reach more people and show them more than once. One day ads are usually not effective.'),
              CustomText(
                text: '\nWhat if my Ads don’t Convert',
                size: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                  text:
                      '\nWork on your sales funnel very well before using our WhatsApp platform for Ads. Our guarantees are to make your material seen by the amount of people you paid for. We cannot predict how the viewers will react to your sponsored post.'),
              CustomText(
                text:
                    '\nCan You Help Us Design with Our Designs and BC (broadcast message)',
                size: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                  text:
                      '\nWe do not assist advertisers with graphics and BC. On request, we can recommend you copywriters who can compose a good broadcast message or designers who can design appealing graphics/video.'),
              CustomText(
                  text:
                      '\nApart from WhatsApp, what other platforms do you promote\nWe can also help you create and manage your Facebook and Instagram sponsored posts.')
            ],
          ),
        ),
      )),
    );
  }
}
