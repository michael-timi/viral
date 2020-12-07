import 'package:flutter/material.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/title.dart';

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
      body: SingleChildScrollView(
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
                      '\nApart from WhatsApp, what other platforms do you promote\nWe can also help you create and manage your Facebook and Instagram sponsored posts.'),
              SizedBox(height: 20)
            ],
          ),
        ),
      )),
    );
  }
}
