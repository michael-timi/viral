import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:viral/models/tv.dart';

class SaveLocation extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  final Tv tv;

  SaveLocation({Key key, this.tv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Tv'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Done'),
            Text('Name: ${tv.name}'),
            Text('Interest: ${tv.interest}'),
            Text('Location: ${tv.location}'),
            Text('Audience: ${tv.audience}'),
            Text('Views: ${tv.views}'),
            Text('Phone: ${tv.phone}'),
            SizedBox(height: 20),
            RaisedButton(
                child: Text('Done'),
                onPressed: () async {
                  //save data to firebase
                  await db.collection('locations').add(tv.toJson());
                  Navigator.of(context).popUntil((route) => route.isFirst);
                })
          ],
        ),
      ),
    );
  }
}
