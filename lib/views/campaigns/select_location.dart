import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:viral/models/campaign.dart';
import 'package:viral/views/campaigns/select_date_and_file.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/title.dart';

class SelectLocation extends StatefulWidget {
  final Campaigns campaigns;

  SelectLocation({Key key, this.campaigns}) : super(key: key);

  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = widget.campaigns.hashtag;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'SELECT WHATSAPP TV(s)',
          color: white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.add_shopping_cart), onPressed: () {})
        ],
      ),
      backgroundColor: white.withOpacity(0.9),
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != '' && name != null)
            ? FirebaseFirestore.instance
                .collection('locations')
                .where('name', arrayContains: name)
                .snapshots()
            : FirebaseFirestore.instance.collection('locations').snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
                    return Hero(
                      transitionOnUserGestures: true,
                      tag: 'SelectedLocation-${data.data()['alias']}',
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0),
                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CustomText(
                                          text: data.data()['alias'],
                                          size: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.monetization_on,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 15,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                                '\N${(data.data()['price'] == null) ? '' : data.data()['price'].toString()}'),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.remove_red_eye,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 15,
                                            ),
                                            SizedBox(width: 5),
                                            Text(data.data()['views']),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_city,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 15,
                                            ),
                                            SizedBox(width: 5),
                                            Text(data.data()['location']),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: height * 0.1,
                                      width: height * 0.1,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          border: Border.all(
                                              width: 1, color: grey)),
                                      child: Image.network(
                                        'https://www.swxbt.com/wp-content/uploads/2020/01/8153.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onLongPress: () {
                              setState(() {});
                            },
                            onTap: () {
                              widget.campaigns.tv = data.data()['alias'];
                              widget.campaigns.views = data.data()['views'];
                              widget.campaigns.price = data.data()['price'];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectDateAndFile(
                                      campaigns: widget.campaigns),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
