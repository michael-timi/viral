import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:viral/models/tv.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/custom_dialog.dart';
import 'package:viral/widget/title.dart';

class CreateLocation extends StatefulWidget {
  final Tv tv;
  final GlobalKey<ScaffoldState> globalKey;

  CreateLocation({Key key, @required this.tv, this.globalKey})
      : super(key: key);

  @override
  _CreateLocationState createState() => _CreateLocationState();
}

class _CreateLocationState extends State<CreateLocation> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _audienceController = TextEditingController();
  TextEditingController _interestController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _viewsController = TextEditingController();
  TextEditingController _mailController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _aliasController = TextEditingController();
  TextEditingController _remittanceController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _limitController = TextEditingController();
  TextEditingController _angelMController = TextEditingController();
  TextEditingController _companyController = TextEditingController();

  String alias,
      name,
      location,
      audience,
      interest,
      phone,
      imageUrl,
      price,
      views,
      remittance,
      angelM,
      company,
      country,
      limit,
      mail;
  int _tvPrice = 0;
  List<Asset> images = List<Asset>();
  List<String> imageUrls = <String>[];
  String _error = 'No Error Dectected';
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    _priceController.addListener(_setPrice);
  }

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

  _setPrive() {
    var price = 0;
    price =
        (_priceController.text == '') ? 0 : int.parse(_priceController.text);
    setState(() {
      _tvPrice = price;
    });
  }

  _setPrice() {
    setState(() {
      _tvPrice = int.parse(_priceController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    //firebase
    final db = Firestore.instance;

    //current date
    DateTime _createdDate = DateTime.now();
    // ignore: unused_local_variable
    var dt = DateFormat.yMMMMEEEEd().format(DateTime.now());

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    Widget tvName = TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Name',
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        name = value;
      },
    );

    Widget tvAlias = TextFormField(
      controller: _aliasController,
      decoration: InputDecoration(
        labelText: 'Alias',
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Alias is Required';
        }

        return null;
      },
      onSaved: (String value) {
        alias = value;
      },
    );

    Widget tvPrice = TextFormField(
      controller: _priceController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Price',
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Price is Required';
        }

        return null;
      },
      onSaved: (String value) {
        price = value;
      },
    );

    Widget tvViews = TextFormField(
      controller: _viewsController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Views',
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Views is Required';
        }

        return null;
      },
      onSaved: (String value) {
        views = value;
      },
    );

    Widget tvInterest = TextFormField(
      controller: _interestController,
      decoration: InputDecoration(
        labelText: 'Interest',
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Interest is Required';
        }

        return null;
      },
      onSaved: (String value) {
        interest = value;
      },
    );

    Widget tvAudience = TextFormField(
      controller: _audienceController,
      decoration: InputDecoration(
        labelText: 'Audience',
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Audience is Required';
        }

        return null;
      },
      onSaved: (String value) {
        audience = value;
      },
    );

    Widget tvEmail = TextFormField(
      controller: _mailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-mail',
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'E-Mail is Required';
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
      onSaved: (String value) {
        mail = value;
      },
    );

    Widget tvPhone = TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Phone No',
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone is Required';
        }

        return null;
      },
      onSaved: (String value) {
        phone = value;
      },
    );

    Widget tvLocation = TextFormField(
      controller: _locationController,
      decoration: InputDecoration(
        labelText: 'Location',
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Location is Required';
        }

        return null;
      },
      onSaved: (String value) {
        location = value;
      },
    );

    Widget tvCountry = TextFormField(
      controller: _countryController,
      decoration: InputDecoration(
        labelText: 'Operating Country',
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Country is Required';
        }

        return null;
      },
      onSaved: (String value) {
        country = value;
      },
    );

    Widget tvRemittance = TextFormField(
      controller: _remittanceController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Remittance',
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Remittance is Required';
        }

        return null;
      },
      onSaved: (String value) {
        remittance = value;
      },
    );

    Widget tvLimit = TextFormField(
      controller: _limitController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Limit',
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Limit is Required';
        }

        return null;
      },
      onSaved: (String value) {
        limit = value;
      },
    );

    Widget tvAngelMarketer = TextFormField(
      controller: _angelMController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Angel Marketer',
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Angel Marketer is Required';
        }

        return null;
      },
      onSaved: (String value) {
        angelM = value;
      },
    );

    Widget tvCompany = TextFormField(
      controller: _companyController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Company',
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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Company is Required';
        }

        return null;
      },
      onSaved: (String value) {
        company = value;
      },
    );

    Widget buildTvForm() {
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
                        Icons.info,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: 'TV INFORMATION',
                        color: black,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: tvName,
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: tvAlias,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: tvViews,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: tvPrice,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.contacts,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: 'CONTACT',
                        color: black,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: tvEmail,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: tvPhone,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.people,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: 'DEMOGRAPHY',
                        color: black,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: tvAudience,
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: tvInterest,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: tvLocation,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: tvCountry,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.more,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: 'PAYOUTS & LIMITS',
                        color: black,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: tvRemittance,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: tvLimit,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: tvAngelMarketer,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: tvCompany,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('CREATE TV'),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(Icons.save),
            ),
            onTap: () async {
              if (!_formKey.currentState.validate()) {
                return;
              } else if (images.length == 0) {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        content: Text("No image selected",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)),
                        actions: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                                child: Text(
                              "Ok",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )),
                          )
                        ],
                      );
                    });
              } else {
                SnackBar snackbar =
                    SnackBar(content: Text('Please wait, saving...'));

                print(_nameController.text);
                print(_aliasController.text);
                print(_viewsController.text);
                print(_priceController.text);
                print(_mailController.text);
                print(_phoneController.text);
                print(_audienceController.text);
                print(_interestController.text);
                print(_locationController.text);
                print(_countryController.text);

                widget.tv.name = _nameController.text;
                widget.tv.alias = _aliasController.text;
                widget.tv.views = _viewsController.text;
                widget.tv.price = _priceController.text;
                widget.tv.mail = _mailController.text;
                widget.tv.phone = _phoneController.text;
                widget.tv.audience = _audienceController.text;
                widget.tv.interest = _interestController.text;
                widget.tv.location = _locationController.text;
                widget.tv.country = _countryController.text;
                widget.tv.remittance = _remittanceController.text;
                widget.tv.angelMarketer = _angelMController.text;
                widget.tv.company = _companyController.text;
                widget.tv.createdAt = _createdDate;
                widget.tv.limit = _limitController.text;

                //save to firebase
                String documnetID =
                    DateTime.now().millisecondsSinceEpoch.toString();
                await db
                    .collection("locations")
                    .document(documnetID)
                    .setData(widget.tv.toJson());
                //widget.globalKey.currentState.showSnackBar(snackbar);
                //uploadImages();
                showDialog(
                    context: context,
                    builder: (_) => CusDialog(
                          title: 'Success',
                          description: 'Tv Created Successfully',
                          ontap: () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                        ));
              }
            },
          )
        ],
      ),
      backgroundColor: white.withOpacity(0.9),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            buildTvForm(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.camera,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 10),
                  CustomText(
                    text: 'SCREENSHOTS',
                    color: black,
                  ),
                ],
              ),
            ),
            Center(
                child: CustomText(
              text: 'Info: $_error',
              color: grey.withOpacity(0),
            )),
            Container(
              height: 180,
              child: Expanded(
                child: buildGridView(),
              ),
            ),
            IconButton(
                onPressed: loadAssets,
                icon: Icon(
                  Icons.add_a_photo,
                  color: Theme.of(context).primaryColor,
                )),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  void uploadImages() {
    for (var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          Firestore.instance
              .collection('locations')
              .document(documnetID)
              .setData({'imageUrl': imageUrls}).then((_) {
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
}
