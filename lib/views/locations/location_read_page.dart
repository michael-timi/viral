import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:viral/models/campaign.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/title.dart';

class LocationReadPage extends StatefulWidget {
  final Campaigns campaigns;

  const LocationReadPage({Key key, this.campaigns}) : super(key: key);
  @override
  _LocationReadPageState createState() => _LocationReadPageState();
}

class _LocationReadPageState extends State<LocationReadPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _tvController = TextEditingController();
  TextEditingController _audienceController = TextEditingController();
  TextEditingController _interestController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  TextEditingController _mailController = TextEditingController();
  TextEditingController _bcController = TextEditingController();
  TextEditingController _captionController = TextEditingController();
  TextEditingController _remittanceController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _limitController = TextEditingController();
  TextEditingController _angelMController = TextEditingController();
  TextEditingController _companyController = TextEditingController();

  String caption,
      hashtag,
      tv,
      audience,
      interest,
      url,
      phone,
      imageUrl,
      bc,
      remittance,
      angelM,
      company,
      country,
      limit,
      mail;
  var _tvPrice = 0;

  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';
  bool isUploading = false;

  Widget buildGridView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          print(asset.getByteData(quality: 100));
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // _nameController.text = widget.tv.name;
    // _captionController.text = widget.tv.alias;
    // _urlController.text = widget.tv.price.toString();
    // _bcController.text = widget.tv.views.toString();
    // _tvController.text = widget.tv.audience;
  }

  @override
  void dispose() {
    _tvController.dispose();
    super.dispose();
  }

  Stream<QuerySnapshot> getLocationsStreamSnapshots(
      BuildContext context) async* {
    yield* FirebaseFirestore.instance.collection('locations').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'SELECT INFLUENCERS',
          color: white,
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
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
                          buildLocationCard(
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

  Widget buildLocationCard(BuildContext context, DocumentSnapshot location) {
    bool isSelected = false;
    TextEditingController _nameController = TextEditingController();
    _nameController.text = location.data()['alias'];
    // ignore: unused_local_variable
    String _name = location.data()['alias'];
    var dt = DateFormat.yMMMMEEEEd().format(DateTime.now());
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        height: 100,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(8), color: white),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomText(
                    text: location.data()['alias'],
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: grey, width: 1)),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.moneyBill,
                              size: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 10),
                            CustomText(
                              text:
                                  '\N${(location.data()['price'] == null) ? '' : location.data()['price'].toString()}',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: grey, width: 1)),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.userFriends,
                              size: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 10),
                            CustomText(
                                text:
                                    '${(location.data()['views'] == null) ? '' : location.data()['views'].toString()}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text:
                            '${(location.data()['location'] == null) ? '' : location.data()['location'].toString()}',
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.cartPlus,
                    color: grey,
                  ),
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
