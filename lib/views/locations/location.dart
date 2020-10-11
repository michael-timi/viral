import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:viral/models/angel_marketer.dart';
import 'package:viral/models/plans.dart';
import 'package:viral/models/tv.dart';
import 'package:viral/views/angel_marketer/create_angel_marketer.dart';
import 'package:viral/views/locations/create_new_location.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/title.dart';

class Location extends StatefulWidget {
  final Tv tv;

  Location({Key key, this.tv}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animatedIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animatedIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(begin: Color(0xFF5dbcd2), end: Color(0xFF5dbcd2))
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.00, 1.00, curve: Curves.linear)));
    _translateButton = Tween<double>(begin: _fabHeight, end: -14.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.75, curve: _curve)));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.didRegisterListener();
    super.dispose();
  }

  //widgets
  Widget buttonTv() {
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateLocation(tv: newTv)));
        },
        tooltip: 'Tv',
        child: Icon(Icons.tv),
      ),
    );
  }

  Widget buttonAngelMarketer() {
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateAngelMarketer(
                        angelMarketer: newAngelMarketer,
                      )));
        },
        tooltip: 'Angel Marketer',
        child: Icon(Icons.person_add),
      ),
    );
  }

  Widget buttonToggle() {
    return Container(
      child: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: animate,
          tooltip: 'Toggle',
          child: AnimatedIcon(
              icon: AnimatedIcons.menu_close, progress: _animatedIcon)),
    );
  }

  animate() {
    if (!isOpened)
      _animationController.forward();
    else
      _animationController.reverse();
    isOpened = !isOpened;
  }

  final newTv = new Tv(null, null, null, null, null, null, null, null, null,
      null, null, null, null, null, null, null, null, null);

  final newAngelMarketer =
      new AngelMarketer(null, null, null, null, null, null, null, null, null);

  final newPlan = new Plan(null, null, null);

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
    TextEditingController _nameController = TextEditingController();

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
                    height: height * 0.05,
                    width: height * 0.05,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(width: 1, color: grey)),
                    child: Image.network(
                      'https://www.swxbt.com/wp-content/uploads/2020/01/8153.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
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
    //var rndno = '';
    var rnd = Random();
    var rndno = rnd.nextInt(9000) + 1000;

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
                0.0, _translateButton.value * 2.0, 0.0),
            child: buttonTv(),
          ),
          Transform(
            transform:
                Matrix4.translationValues(0.0, _translateButton.value, 0.0),
            child: buttonAngelMarketer(),
          ),
          buttonToggle()
        ],
      ),
      backgroundColor: grey.withOpacity(0.15),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.2)
          ],
        ),
      ),
    );
  }
}
