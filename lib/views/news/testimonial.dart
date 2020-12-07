import 'package:flutter/material.dart';
import 'package:viral/models/testimonial.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/title.dart';

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
