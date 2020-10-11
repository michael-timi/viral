import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:viral/models/campaign.dart';
import 'package:viral/models/tv.dart';
import 'package:viral/views/admin/campaign_location_cart.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/title.dart';

class AssignLocation extends StatefulWidget {
  final Campaigns campaigns;

  AssignLocation({Key key, this.campaigns}) : super(key: key);
  @override
  _AssignLocationState createState() => _AssignLocationState();
}

class _AssignLocationState extends State<AssignLocation> {
  Stream<QuerySnapshot> getLocationsStreamSnapshots(
      BuildContext context) async* {
    yield* FirebaseFirestore.instance
        .collection('locations')
        .orderBy('createdAt')
        .snapshots();
  }

  Widget buildLocationViewsCard(
      BuildContext context, DocumentSnapshot location) {
    final locations = Tv.fromSnapshot(location);

    // ignore: unused_local_variable
    var dt = DateFormat.yMMMMEEEEd().format(DateTime.now());
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        height: 100,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(8), color: white),
        child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        text: locations.alias,
                        size: 18,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.monetization_on,
                            size: 15,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: 5),
                          CustomText(
                            text:
                                '\N${(location.data()['price'] == null) ? '' : location.data()['price'].toString()}',
                            size: 12,
                          ),
                        ],
                      ),
                      SizedBox(width: 5),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.remove_red_eye,
                            size: 15,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: 5),
                          CustomText(
                            text:
                                '${(location.data()['views'] == null) ? '' : location.data()['views'].toString()}',
                            size: 12,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_city,
                                size: 15,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(width: 5),
                              CustomText(
                                text:
                                    '${(location.data()['location'] == null) ? '' : location.data()['location'].toString()}',
                                size: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                      height: height * 0.045,
                      width: height * 0.045,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(width: 1, color: grey)),
                      child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SelectCampaignCart(
                                        campaigns: widget.campaigns)));
                          })),
                ],
              ),
            ),
            onLongPress: () {},
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => LocationReadPage(tv: widget.tv),
              //     ));
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: CustomText(
          text: 'SELECT INFLUENCERS | ' + widget.campaigns.hashtag,
          size: 12,
          color: white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.shoppingCart,
                size: 17,
              ),
              onPressed: () {})
        ],
      ),
      backgroundColor: white.withOpacity(0.95),
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: StreamBuilder(
                stream: getLocationsStreamSnapshots(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Column(
                      children: <Widget>[
                        SizedBox(height: 300),
                        SpinKitChasingDots(
                          color: Theme.of(context).primaryColor,
                          size: 50,
                          duration: Duration(seconds: 5),
                        ),
                        SizedBox(height: 20),
                        Text("Loading...")
                      ],
                    );
                  return new ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildLocationViewsCard(
                      context,
                      snapshot.data.documents[index],
                    ),
                  );
                }),
          ),
        ],
      )),
    );
  }
}
