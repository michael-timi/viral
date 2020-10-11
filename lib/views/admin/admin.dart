import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:viral/views/admin/orders.dart';
import 'package:viral/models/angel_marketer.dart';
import 'package:viral/views/locations/location.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/provider.dart';
import 'package:viral/widget/title.dart';

class AdminPage extends StatefulWidget {
  final newAngelMarketer =
      new AngelMarketer(null, null, null, null, null, null, null, null, null);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            title: CustomText(
              text: 'ADMINSTRATOR ONLY',
              fontWeight: FontWeight.bold,
              color: white,
              size: 13,
            ),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.receipt),
                  text: 'Orders',
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.firstOrder),
                  text: "AM Request",
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.users),
                  text: "Influencers",
                ),
              ],
              indicatorColor: Theme.of(context).primaryColorLight,
              indicatorWeight: 5.0,
            )),
        body: TabBarView(
          children: <Widget>[Orders(), AMRequest(), Location()],
        ),
      ),
    );
  }
}

class AMRequest extends StatefulWidget {
  @override
  _AMRequestState createState() => _AMRequestState();
}

class _AMRequestState extends State<AMRequest> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AM extends StatefulWidget {
  @override
  _AMState createState() => _AMState();
}

class _AMState extends State<AM> {
  String selected;
  List Status = ['Pending', 'Contacted'];

  @override
  Widget build(BuildContext context) {
    final newAngelMarketer =
        new AngelMarketer(null, null, null, null, null, null, null, null, null);

    Stream<QuerySnapshot> getLocationsStreamSnapshots(
        BuildContext context) async* {
      // ignore: unused_local_variable
      final uid = await Provider.of(context).auth.getCurrentUID();
      yield* FirebaseFirestore.instance
          .collection('angelMarketers')
          .snapshots();
    }

    Widget buildAMViewsCard(BuildContext context, DocumentSnapshot am) {
      TextEditingController _nameController = TextEditingController();
      _nameController.text = am.data()['name'];
      // ignore: unused_local_variable
      String _name = am.data()['name'];
      // ignore: unused_local_variable
      var dt = DateFormat.yMMMMEEEEd().format(DateTime.now());
      final height = MediaQuery.of(context).size.height;
      // ignore: unused_local_variable
      final width = MediaQuery.of(context).size.width;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Container(
          height: height * 0.09,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: white),
          child: InkWell(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomText(
                          text: am.data()['name'],
                          size: 25,
                        ),
                        Container(
                          child: DropdownButton(
                            elevation: 0,
                            value: selected,
                            hint: Text('Pending'),
                            onChanged: (value) {
                              setState(() {
                                selected = value;
                              });
                            },
                            items: Status.map((value) => DropdownMenuItem(
                                child: Text(value), value: value)).toList(),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.mail,
                              size: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 5),
                            CustomText(text: am.data()['mail']),
                          ],
                        ),
                        SizedBox(width: 5),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.key,
                              size: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 5),
                            CustomText(text: am.data()['id'])
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              onTap: () {}),
        ),
      );
    }

    return Scaffold(
      backgroundColor: grey.withOpacity(0.15),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
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
                          buildAMViewsCard(
                        context,
                        snapshot.data.documents[index],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
