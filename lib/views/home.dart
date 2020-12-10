import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:viral/models/overview.dart';
import 'package:viral/views/admin/admin.dart';
import 'package:viral/views/news/faqs.dart';
import 'package:viral/views/news/testimonial.dart';
import 'package:viral/views/news/update_and_offer.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/contact.dart';
import 'package:viral/widget/home_carousel.dart';
import 'package:viral/widget/news_card.dart';
import 'package:viral/widget/overview_card.dart';
import 'package:viral/widget/title.dart';
import 'package:viral/widget/provider.dart';

List<Overview> overviewList = [
  Overview(name: 'Promotion made', number: 23),
  Overview(name: 'Money spent', number: 21150),
  Overview(name: 'People reached', number: 42309),
];

class Home extends StatefulWidget {
  final User user;

  Home({Key key, this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var dt = DateFormat.yMMMMEEEEd().format(DateTime.now());
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey.withOpacity(0.15),
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.verified_user,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminPage(),
                    ));
              }),
        ],
      ),
      backgroundColor: grey.withOpacity(0.15),
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(height: height * 0.005),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 12.0, left: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                    backgroundColor: white,
                    radius: 30,
                    backgroundImage: AssetImage('assets/user1.jpg')),
              ],
            ),
          ),
          SizedBox(height: 5),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                width: width,
                child: FutureBuilder(
                  future: Provider.of(context).auth.getCurrentUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return displayUserInformation(context, snapshot);
                    } else {
                      return Container();
                    }
                  },
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, right: 12.0, left: 12.0),
            child: CustomText(
              text: '$dt',
              fontWeight: FontWeight.bold,
              size: 10,
            ),
          ),

          //Viral Analytics/Chart
          //VC_Chart(),
          HomeCarousel(),

          //Contact Card
          ContactWidget(),

          //Overview Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
            child: Row(
              children: <Widget>[
                OverviewCard(
                  icon: Icons.notifications_active,
                  title: "Promotion Made",
                  number: '29',
                  color: [Color(0XFF42E695), Color(0XFF3BB2BB)],
                ),
                SizedBox(width: 10),
                OverviewCard(
                  icon: Icons.monetization_on,
                  title: "Money Spent",
                  number: 'N21150',
                  color: [Color(0XFF17EAD9), Color(0XFF6078EA)],
                ),
                SizedBox(width: 10),
                OverviewCard(
                  icon: Icons.people,
                  title: "People Reached",
                  number: '41229',
                  color: [Color(0XFFFCE3BA), Color(0XFFF38181)],
                ),
              ],
            ),
          ),

          //News Card
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                children: <Widget>[
                  NewsWidget(
                    title: 'Update and offers',
                    icon: Icons.arrow_forward,
                    onPress: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateAndOffers(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  NewsWidget(
                    title: 'Testimonials',
                    icon: Icons.arrow_forward,
                    onPress: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Testimonials(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  NewsWidget(
                    title: 'FAQs',
                    icon: Icons.arrow_forward,
                    onPress: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FAQS(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10)
        ],
      )),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;
    return CustomText(
      text:
          'Hello, ${user.displayName == null ? 'User Kindly Update your profile!' : user.displayName + 'User!' ?? 'Anonymous'}',
      color: Theme.of(context).primaryColor,
      size: 20,
    );
  }
}

