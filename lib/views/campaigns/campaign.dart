import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:viral/models/campaign.dart';
import 'package:viral/views/campaigns/campaign_read_page.dart';
import 'package:viral/views/campaigns/create_campaign.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/provider.dart';
import 'package:viral/widget/title.dart';

class Campaign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newCampaign = new Campaigns(null, null, null, null, null, null, null,
        null, null, null, null, null, null, null, null);

    Stream<QuerySnapshot> getUsersCampaignStreamSnapshots(
        BuildContext context) async* {
      final uid = await Provider.of(context).auth.getCurrentUID();
      yield* FirebaseFirestore.instance
          .collection('userData')
          .doc(uid)
          .collection('campaigns')
          .orderBy('startDate')
          .snapshots();
    }

    Widget buildCampaignViewsCard(
        BuildContext context, DocumentSnapshot document) {
      final campaigns = Campaigns.fromSnapshot(document);
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0,
        ),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: white),
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      //CustomText(text: campaigns.hashtag),
                      CustomText(
                        text:
                            "${DateFormat('dd/MM/yyyy').format(campaigns.createdAt).toString()}",
                        size: 10,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CustomText(
                        text:
                            '${(campaigns.hashtag == null) ? '' : campaigns.hashtag.toString()}',
                        size: 18,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
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
                            '${(campaigns.views == null) ? '' : campaigns.views.toString()}',
                        size: 12,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Icon(
                            Icons.timer,
                            size: 15,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: 5),
                          CustomText(
                            text:
                                '${(campaigns.status == null) ? '' : campaigns.status.toString()}',
                            fontStyle: FontStyle.italic,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CampaignReadPage(
                    campaigns: campaigns,
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey.withOpacity(0.15),
        elevation: 0.0,
        title: CustomText(
          text: 'CAMPAIGNS',
          size: 12,
          color: black,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Create_Campaign(campaigns: newCampaign),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: white,
        ),
      ),
      backgroundColor: grey.withOpacity(0.15),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: StreamBuilder(
                  stream: getUsersCampaignStreamSnapshots(context),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Column(
                        children: <Widget>[
                          SizedBox(height: 300),
                          SpinKitChasingDots(
                            color: Theme.of(context).primaryColor,
                            size: 30,
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
                          buildCampaignViewsCard(
                        context,
                        snapshot.data.documents[index],
                      ),
                    );
                  }),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2)
          ],
        ),
      ),
    );
  }
}
