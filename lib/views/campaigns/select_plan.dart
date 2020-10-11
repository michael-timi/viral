import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viral/models/campaign.dart';
import 'package:viral/models/plans.dart';
import 'package:viral/views/campaigns/select_date_and_file.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/title.dart';

class SelectPlan extends StatefulWidget {
  final Campaigns campaigns;

  SelectPlan({Key key, this.campaigns}) : super(key: key);

  @override
  _SelectPlanState createState() => _SelectPlanState();
}

class _SelectPlanState extends State<SelectPlan> {
  String name = '';
  final List<Plan> _smallplanList = [
    Plan(1, "5,000", 2750),
    Plan(2, "10,000", 5500),
    Plan(3, "20,000", 11000),
    Plan(4, "30,000", 16500),
    Plan(5, "40,000", 22000),
    Plan(6, "100,000", 55000),
    Plan(7, "200,000", 110000),
    Plan(8, "300,000", 165000),
    Plan(9, "400,000", 220000),
    Plan(10, "500,000", 275000),
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = widget.campaigns.hashtag;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: 'SELECT CAMPAIGN PLAN',
            size: 12,
            color: white,
            fontWeight: FontWeight.bold,
          ),
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, size: 20),
              onPressed: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _smallplanList.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildSmallPlanCard(context, index),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildSmallPlanCard(BuildContext context, int index) {
    final height = MediaQuery.of(context).size.height;
    return Hero(
      transitionOnUserGestures: true,
      tag: 'SelectedPlan-${_smallplanList[index].reach}',
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: white),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.people,
                              color: Theme.of(context).primaryColor,
                              size: 18,
                            ),
                            SizedBox(width: 10),
                            CustomText(
                              text:
                                  '${_smallplanList[index].reach}' + 'K Views',
                              fontWeight: FontWeight.bold,
                              size: 15,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.moneyBill,
                              color: Theme.of(context).primaryColor,
                              size: 18,
                            ),
                            SizedBox(width: 10),
                            CustomText(
                              text:
                                  '\N${_smallplanList[index].price.toString()}',
                              size: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: height * 0.04,
                          width: height * 0.04,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(width: 1, color: grey)),
                          child: Icon(
                            FontAwesomeIcons.trophy,
                            size: 15,
                            color: Theme.of(context).primaryColor,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            onLongPress: () {
              setState(() {});
            },
            onTap: () {
              widget.campaigns.views = _smallplanList[index].reach;
              widget.campaigns.price = _smallplanList[index].price;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SelectDateAndFile(campaigns: widget.campaigns),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
