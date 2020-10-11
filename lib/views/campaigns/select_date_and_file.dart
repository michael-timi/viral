import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:viral/models/campaign.dart';
import 'package:viral/views/campaigns/save_campaign.dart';
import 'package:viral/views/upload_file.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/custom_dialog.dart';
import 'package:viral/widget/title.dart';

class SelectDateAndFile extends StatefulWidget {
  final Campaigns campaigns;
  final GlobalKey<ScaffoldState> globalKey;

  SelectDateAndFile({Key key, this.campaigns, this.globalKey})
      : super(key: key);

  @override
  _SelectDateAndFileState createState() => _SelectDateAndFileState();
}

class _SelectDateAndFileState extends State<SelectDateAndFile> {
  final _globalKey = GlobalKey<ScaffoldState>();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 3));

  File _video;
  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];

  // ignore: unused_field
  String _error = 'No Error Dectected';
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        print(asset.getByteData(quality: 100));
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: AssetThumb(
              asset: asset,
              width: 300,
              height: 300,
            ),
          ),
        );
      }),
    );
  }

  void uploadImages() {
    for (var imageFile in images) {
      postImage(imageFile).then((downloadUrl) async {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          final uid = await Provider.of(context).auth.getCurrentUID();
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          FirebaseFirestore.instance
              .collection('images')
              .doc(documnetID)
              .set({'urls': imageUrls}).then((_) {
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
          actionBarColor: "#abcdef",
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
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

  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: new DateTime(DateTime.now().year - 50),
        lastDate: new DateTime(DateTime.now().year + 50));
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
      });
    }
  }

  Widget buildButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Icon(Icons.calendar_today),
          color: Theme.of(context).primaryColor,
          textColor: white,
          onPressed: () async {
            await displayDateRangePicker(context);
          },
        ),
      ],
    );
  }

  Widget buildingSelectedDates() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Start Date"),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                      "${DateFormat('MM-dd').format(_startDate).toString()}",
                      style: TextStyle(fontSize: 35, color: Colors.deepPurple)),
                ),
                Text("${DateFormat('yyyy').format(_startDate).toString()}",
                    style: TextStyle(color: Colors.deepPurple)),
              ],
            ),
            Container(
                child: Icon(
              Icons.arrow_forward,
              color: Colors.deepOrange,
              size: 45,
            )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("End Date"),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                      "${DateFormat('MM-dd').format(_endDate).toString()}",
                      style: TextStyle(fontSize: 35, color: Colors.deepPurple)),
                ),
                Text("${DateFormat('yyyy').format(_endDate).toString()}",
                    style: TextStyle(color: Colors.deepPurple)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget buildSelectedPlan(BuildContext context, Campaigns campaigns) {
      final height = MediaQuery.of(context).size.height;

      return Hero(
        tag: "SelectedLocation-${campaigns.views}",
        transitionOnUserGestures: true,
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: SingleChildScrollView(
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, bottom: 12.0, top: 12.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.people,
                                  color: Theme.of(context).primaryColor,
                                  size: 18,
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: AutoSizeText(
                                      widget.campaigns.views + 'K Views',
                                      maxLines: 3,
                                      style: TextStyle(fontSize: 15.0)),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
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
                                        'N' + widget.campaigns.price.toString(),
                                    size: 15),
                              ],
                            ),
                          ],
                        ),
                      ),
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
          ),
        ),
      );
    }

    void pickVideo() async {
      // ignore: deprecated_member_use
      var video = await ImagePicker.pickVideo(source: ImageSource.gallery);
      setState(() {
        _video = video;
        print('video: $_video');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            text: 'DATE AND MEDIA | 2/2',
            color: white,
            size: 14,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              print(_startDate);
              print(_endDate);
              widget.campaigns.startDate = _startDate;
              widget.campaigns.endDate = _endDate;
              if (images.length == 0) {
                showDialog(
                    context: context,
                    builder: (_) => CusDialog(
                          title: 'No image selected',
                          description: 'Select your campaign files to proceed',
                          ontap: () {
                            Navigator.pop(context);
                          },
                        ));
              } else {
                uploadImages();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SaveCampaign(campaigns: widget.campaigns)),
                );
              }
            },
            child: Row(
              children: <Widget>[
                CustomText(
                  text: 'NEXT',
                  size: 1,
                  color: white,
                  fontWeight: FontWeight.bold,
                ),
                Icon(Icons.check, color: white),
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.category,
                          color: Theme.of(context).primaryColor, size: 20),
                      SizedBox(width: 10),
                      CustomText(text: 'SELECTED PLAN', color: grey, size: 12),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              buildSelectedPlan(context, widget.campaigns),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                          text: 'SELECT DATE RANGE', color: grey, size: 12),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.edit,
                        color: Theme.of(context).primaryColor, size: 20),
                    onPressed: () async {
                      await displayDateRangePicker(context);
                    },
                  ),
                ],
              ),
              buildingSelectedDates(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.photo,
                          color: Theme.of(context).primaryColor, size: 20),
                      SizedBox(width: 10),
                      CustomText(
                          text: 'SELECT CAMPAIGN FILE', color: grey, size: 12),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadImage()));
                      },
                      icon: Icon(Icons.add_a_photo,
                          color: Theme.of(context).primaryColor, size: 20)),
                ],
              ),
              Center(
                  child: CustomText(
                text: 'Info: $_error',
                color: white,
              )),
              Expanded(
                child: buildGridView(),
              ),

              InkWell(
                onTap: () {
                  if (images.length == 0) {
                    showDialog(
                        context: context,
                        builder: (_) => CusDialog(
                              title: 'No image selected',
                              description:
                                  'Select your campaign files to proceed',
                              ontap: () {
                                Navigator.pop(context);
                              },
                            ));
                  } else {
                    uploadImages();
                  }
                },
                child: Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Theme.of(context).primaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.cloud_upload, color: white),
                      CustomText(text: 'Upload Files', color: white)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100)
              // Column(
              //   children: <Widget>[
              //     Row(
              //       children: <Widget>[
              //         Icon(Icons.ondemand_video,
              //             color: Theme.of(context).primaryColor, size: 20),
              //         SizedBox(width: 10),
              //         CustomText(text: 'Video', size: 12),
              //       ],
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(20.0),
              //       child: GestureDetector(
              //         onTap: pickVideo,
              //         child: Container(
              //             height: 150,
              //             width: MediaQuery.of(context).size.width,
              //             color: black.withOpacity(0.2),
              //             child: _video == null
              //                 ? Icon(
              //                     Icons.play_arrow,
              //                     size: 40,
              //                   )
              //                 : Image.file(_video)),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      )),
    );
  }
}
