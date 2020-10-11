import 'package:flutter/material.dart';
import 'package:viral/models/campaign.dart';
import 'package:viral/views/campaigns/select_plan.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/title.dart';

// ignore: camel_case_types
class Create_Campaign extends StatefulWidget {
  final Campaigns campaigns;

  Create_Campaign({Key key, this.campaigns}) : super(key: key);

  @override
  _Create_CampaignState createState() => _Create_CampaignState();
}

// ignore: camel_case_types
class _Create_CampaignState extends State<Create_Campaign> {
  @override
  Widget build(BuildContext context) {
    String caption, hashtag, url, bc, location;

    //form validation key
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    //textfield controller
    TextEditingController _captionController = new TextEditingController();
    TextEditingController _hashtagController = new TextEditingController();
    TextEditingController _urlController = new TextEditingController();
    TextEditingController _bcController = new TextEditingController();
    TextEditingController _locationController = new TextEditingController();

    _locationController.text = widget.campaigns.location;
    _hashtagController.text = widget.campaigns.hashtag;
    _captionController.text = widget.campaigns.caption;
    _urlController.text = widget.campaigns.url;
    _bcController.text = widget.campaigns.bc;

    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: 'CREATE CAMPAIGN | 1/2',
            size: 12,
            color: white,
            fontWeight: FontWeight.bold,
          ),
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, size: 20),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                } else {
                  print(_hashtagController.text);
                  print(_captionController.text);
                  print(_urlController.text);
                  print(_bcController.text);
                  print(_locationController.text);

                  widget.campaigns.hashtag = _hashtagController.text;
                  widget.campaigns.caption = _captionController.text;
                  widget.campaigns.url = _urlController.text;
                  widget.campaigns.bc = _bcController.text;
                  widget.campaigns.location = _locationController.text;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SelectPlan(campaigns: widget.campaigns),
                    ),
                  );
                }
              },
              child: Row(
                children: <Widget>[
                  CustomText(
                    text: 'NEXT',
                    size: 12,
                    color: white,
                    fontWeight: FontWeight.bold,
                  ),
                  Icon(
                    Icons.check,
                    color: white,
                    size: 20,
                  ),
                ],
              ),
            )
          ],
        ),
        backgroundColor: white.withOpacity(0.9),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.info,
                                    size: 15,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(width: 10),
                                  CustomText(
                                    text: 'CAMPAIGN INFORMATION',
                                    color: black,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _hashtagController,
                                decoration: InputDecoration(
                                  labelText: 'Hashtag',
                                  labelStyle: TextStyle(fontSize: 12),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(color: white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(color: white)),
                                  hintStyle: TextStyle(fontSize: 12),
                                  hintText: 'e.g #yourhashtag',
                                  filled: true,
                                  fillColor: white,
                                  focusColor: white,
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 10.0, top: 10.0),
                                ),
                                style: TextStyle(fontSize: 12),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Hashtag is required for your promotion';
                                  }
                                  if (!RegExp(r"(#+[a-zA-Z0-9(_)]{1,})")
                                      .hasMatch(value)) {
                                    return '`#` must start';
                                  }

                                  return null;
                                },
                                onSaved: (String value) {
                                  hashtag = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _captionController,
                                decoration: InputDecoration(
                                  labelText: 'Caption',
                                  labelStyle: TextStyle(fontSize: 12),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(color: white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(color: white)),
                                  filled: true,
                                  hintStyle: TextStyle(fontSize: 12),
                                  fillColor: white,
                                  focusColor: white,
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 10.0, top: 10.0),
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
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _urlController,
                                decoration: InputDecoration(
                                  labelText: 'CTA Url',
                                  labelStyle: TextStyle(fontSize: 12),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(color: white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(color: white)),
                                  filled: true,
                                  hintStyle: TextStyle(fontSize: 12),
                                  fillColor: white,
                                  focusColor: white,
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 10.0, top: 10.0),
                                ),
                                style: TextStyle(fontSize: 12),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'URL is Required';
                                  }

                                  return null;
                                },
                                onSaved: (String value) {
                                  url = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _locationController,
                                decoration: InputDecoration(
                                  labelText: 'Target Location',
                                  labelStyle: TextStyle(fontSize: 12),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(color: white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(color: white)),
                                  hintStyle: TextStyle(fontSize: 12),
                                  hintText: 'Lagos and Oyo State',
                                  filled: true,
                                  fillColor: white,
                                  focusColor: white,
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 10.0, top: 10.0),
                                ),
                                style: TextStyle(fontSize: 12),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Target location is required';
                                  }

                                  return null;
                                },
                                onSaved: (String value) {
                                  location = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _bcController,
                                decoration: InputDecoration(
                                  labelText: 'Broadcast',
                                  labelStyle: TextStyle(fontSize: 12),
                                  hintStyle: TextStyle(fontSize: 12),
                                  helperStyle: TextStyle(fontSize: 12),
                                  errorStyle: TextStyle(fontSize: 12),
                                  counterStyle: TextStyle(fontSize: 12),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(color: white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(color: white)),
                                  filled: true,
                                  fillColor: white,
                                  focusColor: white,
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 10.0, top: 10.0),
                                ),
                                maxLength: 500,
                                maxLines: 10,
                                style: TextStyle(fontSize: 12),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'BC is Required';
                                  }

                                  return null;
                                },
                                onSaved: (String value) {
                                  bc = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
