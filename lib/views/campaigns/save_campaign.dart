import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:viral/models/campaign.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/custom_dialog.dart';
import 'package:viral/widget/provider.dart';
import 'package:viral/widget/title.dart';

class SaveCampaign extends StatefulWidget {
  final Campaigns campaigns;

  SaveCampaign({Key key, this.campaigns}) : super(key: key);

  @override
  _SaveCampaignState createState() => _SaveCampaignState();
}

class _SaveCampaignState extends State<SaveCampaign> {
  final db = FirebaseFirestore.instance;

  DateTime _startDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    //get date difference
    var date = widget.campaigns.endDate.difference(widget.campaigns.startDate);
    var day = date.inDays + 1;

    //get campaign amount
    var amount = widget.campaigns.price;
    var totalAmount = amount * day;
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'CAMPAIGN SUMMARY',
          color: white,
          fontWeight: FontWeight.bold,
          size: 14,
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                print(widget.campaigns.hashtag);
                print(widget.campaigns.caption);
                print(widget.campaigns.url);
                print(widget.campaigns.bc);
                print(widget.campaigns.location);
                print(widget.campaigns.endDate);
                print(widget.campaigns.startDate);
                print(widget.campaigns.tv);
                print(widget.campaigns.price);
              })
        ],
        centerTitle: true,
      ),
      backgroundColor: white.withOpacity(0.95),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SizedBox(height: height * 0.1),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomText(
                  text: widget.campaigns.hashtag,
                  size: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Container(
                height: height * 0.25,
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0), color: white),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: 'Duration',
                            color: grey,
                            size: 15,
                          ),
                          CustomText(
                            text: day == 1
                                ? (day).toString() + ' Day'
                                : (day).toString() + ' Days',
                            color: grey,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: 'Start Date',
                            color: grey,
                            size: 15,
                          ),
                          CustomText(
                            text:
                                "${DateFormat('dd-MM-yyyy').format(widget.campaigns.startDate).toString()}",
                            color: grey,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: 'End Date',
                            color: grey,
                            size: 15,
                          ),
                          CustomText(
                            text:
                                "${DateFormat('dd-MM-yyyy').format(widget.campaigns.endDate).toString()}",
                            color: grey,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                            text: 'Total Amount',
                            size: 15,
                            color: grey,
                          ),
                          CustomText(
                            text: 'N' +
                                totalAmount
                                    .toString(), // + totalAmount.toString(),
                            color: grey,
                            size: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              child: InkWell(
                child: Container(
                  height: height * 0.05,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Theme.of(context).primaryColor),
                  child: Center(
                      child: CustomText(
                    text: 'CREATE CAMPAIGN',
                    fontWeight: FontWeight.bold,
                    color: white,
                  )),
                ),
                onTap: () async {
                  //data
                  widget.campaigns.createdAt = _startDate;

                  //save to firebase
                  final uid = await Provider.of(context).auth.getCurrentUID();
                  await db
                      .collection('userData')
                      .doc(uid)
                      .collection('campaigns')
                      .add(widget.campaigns.toJson());

                  showDialog(
                    context: context,
                    builder: (_) => CusDialog(
                      title: 'Success',
                      description:
                          'Campaign created successfully! Proceed to payment',
                      ontap: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      buttonText: 'OK',
                    ),
                  );
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void saveCampaign() {
    FirebaseFirestore.instance
        .collection('campaigns')
        .add(widget.campaigns.toJson());
  }
}
