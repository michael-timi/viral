import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:viral/models/campaign.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/title.dart';

class CampaignMediaReadPage extends StatefulWidget {
  final Campaigns campaigns;

  CampaignMediaReadPage({Key key, this.campaigns}) : super(key: key);

  @override
  _CampaignMediaReadPageState createState() => _CampaignMediaReadPageState();
}

class _CampaignMediaReadPageState extends State<CampaignMediaReadPage> {
  List<NetworkImage> _listOfImages = <NetworkImage>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'YOU CAN CHANGE CREATIVES',
          color: white,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cloud_upload),
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: black,
      body: SafeArea(
        child: Container(
          child: Flexible(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('images').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          _listOfImages = [];
                          for (int i = 0;
                              i <
                                  snapshot.data.docs[index]
                                      .data()['urls']
                                      .length;
                              i++) {
                            _listOfImages.add(NetworkImage(
                                snapshot.data.docs[index].data()['urls'][i]));
                          }
                          return Container(
                            margin: EdgeInsets.all(10.0),
                            height: MediaQuery.of(context).size.height * 0.88,
                            decoration: BoxDecoration(
                              color: black,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Carousel(
                                boxFit: BoxFit.contain,
                                images: _listOfImages,
                                autoplay: false,
                                indicatorBgPadding: 5.0,
                                dotPosition: DotPosition.bottomCenter,
                                animationCurve: Curves.fastOutSlowIn,
                                animationDuration:
                                    Duration(milliseconds: 2000)),
                          );
                          //     Container(
                          //       height: 1,
                          //       width: MediaQuery.of(context).size.width,
                          //       color: Colors.red,

                          // );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
