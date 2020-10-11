import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:viral/models/campaign.dart';
import 'package:viral/views/campaigns/campaign_media_page.dart';
import 'package:viral/views/campaigns/campaign_payment.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/custom_dialog.dart';
import 'package:viral/widget/provider.dart';
import 'package:viral/widget/title.dart';

class CampaignReadPage extends StatefulWidget {
  final Campaigns campaigns;

  CampaignReadPage({Key key, this.campaigns}) : super(key: key);

  @override
  _CampaignReadPageState createState() => _CampaignReadPageState();
}

class _CampaignReadPageState extends State<CampaignReadPage> {
  TextEditingController _hashtagController = TextEditingController();
  TextEditingController _tvController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  TextEditingController _bcController = TextEditingController();
  TextEditingController _captionController = TextEditingController();

  String caption, hashtag, url, imageUrl, bc;
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
    _hashtagController.text = widget.campaigns.hashtag;
    _captionController.text = widget.campaigns.caption;
    _urlController.text = widget.campaigns.url;
    _bcController.text = widget.campaigns.bc;
    _tvController.text = widget.campaigns.tv;
  }

  @override
  void dispose() {
    _tvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    Widget cTv = TextFormField(
      controller: _tvController,
      enabled: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.queue_play_next,
          color: Theme.of(context).primaryColor,
        ),
        contentPadding: const EdgeInsets.only(left: 14.0, top: 15.0),
        filled: true,
        fillColor: white,
      ),
    );

    Widget cCaption = TextFormField(
      controller: _captionController,
      decoration: InputDecoration(
        labelText: 'Caption',
        labelStyle: TextStyle(fontSize: 12),
        hintStyle: TextStyle(fontSize: 12),
        helperStyle: TextStyle(fontSize: 12),
        errorStyle: TextStyle(fontSize: 12),
        counterStyle: TextStyle(fontSize: 12),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(color: white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(color: white)),
        filled: true,
        fillColor: white,
        focusColor: white,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
      ),
      maxLength: 100,
      style: TextStyle(fontSize: 12),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Caption is Required';
        }

        return null;
      },
      onSaved: (String value) {
        caption = value;
      },
    );

    Widget cBc = TextFormField(
      controller: _bcController,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: 'Broadcast',
        labelStyle: TextStyle(fontSize: 12),
        hintStyle: TextStyle(fontSize: 12),
        helperStyle: TextStyle(fontSize: 12),
        errorStyle: TextStyle(fontSize: 12),
        counterStyle: TextStyle(fontSize: 12),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(color: white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(color: white)),
        filled: true,
        fillColor: white,
        focusColor: white,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
      ),
      maxLines: 5,
      style: TextStyle(fontSize: 12),
      maxLength: 500,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Broadcast is Required';
        }

        return null;
      },
      onSaved: (String value) {
        bc = value;
      },
    );

    Widget cUrl = TextFormField(
      controller: _urlController,
      keyboardType: TextInputType.url,
      decoration: InputDecoration(
        labelText: 'Url',
        labelStyle: TextStyle(fontSize: 12),
        hintStyle: TextStyle(fontSize: 12),
        helperStyle: TextStyle(fontSize: 12),
        errorStyle: TextStyle(fontSize: 12),
        counterStyle: TextStyle(fontSize: 12),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(color: white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(color: white)),
        filled: true,
        fillColor: white,
        focusColor: white,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
      ),
      style: TextStyle(fontSize: 12),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Url is Required';
        }

        return null;
      },
      onSaved: (String value) {
        url = value;
      },
    );

    Widget buildCampaignInfo() {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.notifications_active,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: 'CAMPAIGN INFORMATION',
                        color: black,
                        size: 13,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: cCaption,
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: cUrl,
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: cBc,
                ),
//                Container(
//                  height: 80,
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(4.0), color: white),
//                  padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
//                  child: Column(
//                    children: <Widget>[
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Text('Selected TV(s)'),
//                          Row(
//                            children: <Widget>[
//                              Text('No of TV(s)'),
//                              SizedBox(width: 5),
//                              Icon(Icons.view_list,
//                                  color: Theme.of(context).primaryColor)
//                            ],
//                          ),
//                        ],
//                      ),
//                      cTv,
//                    ],
//                  ),
//                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget buildSelectedDateInfo() {
      //get date difference
      var date =
          widget.campaigns.endDate.difference(widget.campaigns.startDate);
      var day = date.inDays + 1;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: white),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Duration', style: TextStyle(fontSize: 12)),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 5),
                        CustomText(
                          text: day == 1
                              ? (day).toString() + ' Day'
                              : (day).toString() + ' Days',
                          color: black,
                          fontWeight: FontWeight.bold,
                          size: 13,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    SizedBox(width: 15),
                    Icon(
                      Icons.date_range,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: 15),
                    CustomText(
                        text:
                            "${DateFormat('MM/dd/yyyy').format(widget.campaigns.startDate).toString()} - ${DateFormat('MM/dd/yyyy').format(widget.campaigns.endDate).toString()}",
                        size: 13),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget buildPaymentInfo() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: white),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('AdSpend'),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    SizedBox(width: 15),
                    Icon(Icons.monetization_on,
                        color: Theme.of(context).primaryColor),
                    SizedBox(width: 15),
                    CustomText(
                      text: 'N ${(widget.campaigns.price).toString()}',
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget buildScreenshotInfo() {
      List<NetworkImage> _listOfImages = <NetworkImage>[];

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: white),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Creatives', style: TextStyle(fontSize: 12)),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(width: 15),
                        Icon(Icons.image,
                            color: Theme.of(context).primaryColor, size: 50),
                      ],
                    ),
                    InkWell(
                        child: Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CampaignMediaReadPage(
                                    campaigns: widget.campaigns),
                              ));
                        })
                  ],
                ),
                // Flexible(
                //     child: StreamBuilder<QuerySnapshot>(
                //         stream: Firestore.instance
                //             .collection('campaigns')
                //             .snapshots(),
                //         builder: (context, snapshot) {
                //           if (snapshot.hasData) {
                //             return ListView.builder(
                //                 itemCount: snapshot.data.documents.length,
                //                 itemBuilder: (BuildContext context, int index) {
                //                   _listOfImages = [];
                //                   for (int i = 0;
                //                       i <
                //                           snapshot.data.documents[index]
                //                               .data['urls'].length;
                //                       i++) {
                //                     _listOfImages.add(NetworkImage(snapshot.data
                //                         .documents[index].data['urls'][i]));
                //                   }
                //                   return Column(
                //                     children: <Widget>[
                //                       Container(
                //                         margin: EdgeInsets.all(10.0),
                //                         height: 200,
                //                         decoration: BoxDecoration(
                //                           color: Colors.white,
                //                         ),
                //                         width:
                //                             MediaQuery.of(context).size.width,
                //                         child: Carousel(
                //                             boxFit: BoxFit.cover,
                //                             images: _listOfImages,
                //                             autoplay: false,
                //                             indicatorBgPadding: 5.0,
                //                             dotPosition:
                //                                 DotPosition.bottomCenter,
                //                             animationCurve:
                //                                 Curves.fastOutSlowIn,
                //                             animationDuration:
                //                                 Duration(milliseconds: 2000)),
                //                       ),
                //                       Container(
                //                         height: 1,
                //                         width:
                //                             MediaQuery.of(context).size.width,
                //                         color: Colors.red,
                //                       )
                //                     ],
                //                   );
                //                 });
                //           } else {
                //             return Center(
                //               child: CircularProgressIndicator(),
                //             );
                //           }
                //         })),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: widget.campaigns.hashtag,
          size: 15,
          color: white,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              widget.campaigns.caption = _captionController.text;
              widget.campaigns.url = _urlController.text;
              widget.campaigns.bc = _bcController.text;
              await updateCampaign(context);
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text('Are you sure?',
                              style: TextStyle(fontSize: 12)),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: CustomText(text: 'Cancel', size: 15)),
                              //SizedBox(width: 40),
                              MaterialButton(
                                  onPressed: () async {
                                    await deleteCampaign(context);
                                    showDialog(
                                        context: context,
                                        builder: (_) => CusDialog(
                                              title: 'Deleted',
                                              description:
                                                  'Campaign Deleted successfully!',
                                              ontap: () {
                                                Navigator.of(context).popUntil(
                                                    (route) => route.isFirst);
                                              },
                                            ));
                                  },
                                  child: CustomText(text: 'OK', size: 15)),
                            ],
                          ),
                        ));
              })
        ],
      ),
      body: SafeArea(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                buildCampaignInfo(),
                buildSelectedDateInfo(),
                buildScreenshotInfo(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: InkWell(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Color(0xFF41aa5e)),
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: 'PAY NOW',
                          color: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTap: () async {
                      await FirebaseFirestore.instance
                          .collection('campaigns')
                          .add(widget.campaigns.toJson());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CampaignPayment(
                            campaigns: widget.campaigns,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  void uploadImages() {
    for (var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          FirebaseFirestore.instance
              .collection('locations')
              .doc(documnetID)
              .set({'imageUrl': imageUrls}).then((_) {
            Text('Uploaded Successfully');
            // widget.globalKey.currentState.showSnackBar(snackbar);
            setState(() {
              images = [];
              imageUrls = [];
            });
          });
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarTitle: "Select campaign files",
          allViewTitle: "All Photos",
          useDetailsView: true,
          // selectCircleStrokeColor: "#000000",
        ),
      );
      print(resultList.length);
      print((await resultList[0].getThumbByteData(122, 100)));
      print((await resultList[0].getByteData()));
      print((await resultList[0].metadata));
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;
    setState(() {
      images = resultList;
      _error = error;
    });
  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask =
        reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  Future updateCampaign(context) async {
    var uid = await Provider.of(context).auth.getCurrentUID();
    final doc = FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection("campaigns")
        .doc(widget.campaigns.documentId);

    return await doc.set(widget.campaigns.toJson());
  }

  Future deleteCampaign(context) async {
    var uid = await Provider.of(context).auth.getCurrentUID();
    final doc = FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection("campaigns")
        .doc(widget.campaigns.documentId);

    return await doc.delete();
  }
}
