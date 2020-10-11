import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viral/models/user.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/custom_dialog.dart';
import 'package:viral/widget/provider.dart';
import 'package:viral/widget/title.dart';

class EditUserInfo extends StatefulWidget {
  final User user;

  EditUserInfo({Key key, this.user}) : super(key: key);

  @override
  _EditUserInfoState createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  User user = User(null, null, null, null, null, null, null, null, null, null,
      null, null, null, null);
  String fname, lname, phone, mail, amCode, pin, cPin;
  bool _isAdmin = false;

  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _mailController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _websiteController = TextEditingController();
  TextEditingController _whatsappController = TextEditingController();
  TextEditingController _instagramController = TextEditingController();
  TextEditingController _facebookController = TextEditingController();
  TextEditingController _twitterController = TextEditingController();
  TextEditingController _linkedInController = TextEditingController();
  TextEditingController _accountManagerController = TextEditingController();
  TextEditingController _pinController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   _accountManagerController.text = widget.views.user.accountmanager;
  //   _instagramController.text = widget.views.user.instagram;
  //   _facebookController.text = widget.views.user.facebook;
  //   _twitterController.text = widget.views.user.twitter;
  //   _linkedInController.text = widget.views.user.linkedin;
  //   _whatsappController.text = widget.views.user.whatsapp;
  //   _websiteController.text = widget.views.user.website;
  //   _addressController.text = widget.views.user.address;
  //   _mailController.text = widget.views.user.email;
  //   _phoneController.text = widget.views.user.phone;
  //   _lnameController.text = widget.views.user.lastname;
  //   _brandController.text = widget.views.user.brand;
  // }

  @override
  void dispose() {
    //_tvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    Widget acFname = TextFormField(
      controller: _fnameController,
      decoration: InputDecoration(
        labelText: 'First Name',
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
          return 'First name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        fname = value;
      },
    );

    Widget acLname = TextFormField(
      controller: _lnameController,
      decoration: InputDecoration(
        labelText: 'Last Name',
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
          return 'Last name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        lname = value;
      },
    );

    Widget acAddress = TextFormField(
      controller: _addressController,
      decoration: InputDecoration(
        labelText: 'Address (Optional)',
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
    );

    Widget acWebsite = TextFormField(
      controller: _websiteController,
      decoration: InputDecoration(
        labelText: 'Website (Optional)',
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
    );

    Widget acBrand = TextFormField(
      controller: _brandController,
      decoration: InputDecoration(
        labelText: 'Brand (Optional)',
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
    );

    Widget acEmail = TextFormField(
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

    Widget acManager = TextFormField(
      controller: _accountManagerController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'AM Code',
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
          return 'AM Code is Required';
        }

        return null;
      },
      onSaved: (String value) {
        amCode = value;
      },
    );

    Widget acWhatsapp = TextFormField(
      controller: _whatsappController,
      decoration: InputDecoration(
        icon: Icon(FontAwesomeIcons.whatsapp),
        labelText: 'Whatsapp',
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
    );

    Widget acInstagram = TextFormField(
      controller: _instagramController,
      decoration: InputDecoration(
        icon: Icon(FontAwesomeIcons.instagram),
        labelText: 'Instagram',
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
    );

    Widget acFacebook = TextFormField(
      controller: _facebookController,
      decoration: InputDecoration(
        icon: Icon(FontAwesomeIcons.whatsapp),
        labelText: 'Facebook',
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
    );

    Widget acTwitter = TextFormField(
      controller: _twitterController,
      decoration: InputDecoration(
        icon: Icon(FontAwesomeIcons.twitter),
        labelText: 'Twitter',
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
    );

    Widget acLinkedLn = TextFormField(
      controller: _linkedInController,
      decoration: InputDecoration(
        icon: Icon(FontAwesomeIcons.linkedin),
        labelText: 'Linkedin',
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
    );

    Widget buildEditUserForm() {
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
                adminFeature(),
                FutureBuilder(
                    future: _getProfileData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        _fnameController.text = widget.user.firstname;
                        _lnameController.text = widget.user.lastname;
                        _brandController.text = widget.user.brand;
                        _mailController.text = widget.user.email;
                        _addressController.text = widget.user.address;
                        _websiteController.text = widget.user.website;
                        _accountManagerController.text =
                            widget.user.accountmanager;
                        _whatsappController.text = widget.user.whatsapp;
                        _instagramController.text = widget.user.instagram;
                        _facebookController.text = widget.user.facebook;
                        _twitterController.text = widget.user.twitter;
                        _linkedInController.text = widget.user.linkedin;
                        _isAdmin = widget.user.admin ?? false;
                      }
                      return Container(
                          child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.verified_user,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: 10),
                                CustomText(
                                  text: 'USER IDENTITY',
                                  color: black,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  child: acFname,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  child: acLname,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: acBrand,
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.phone,
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
                            padding: const EdgeInsets.all(4),
                            child: acEmail,
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: acAddress,
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: acWebsite,
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.addressBook,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: 10),
                                CustomText(
                                  text: 'ACCOUNT MANAGER',
                                  color: black,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: acManager,
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.internetExplorer,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: 10),
                                CustomText(
                                  text: 'SOCIALS (Optional)',
                                  color: black,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: acWhatsapp,
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: acInstagram,
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: acFacebook,
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: acTwitter,
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            child: acLinkedLn,
                          ),
                        ],
                      ));
                    }),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'EDIT ACCOUNT',
          color: white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                if (!_formKey.currentState.validate()) {
                  return;
                } else {
                  widget.user.firstname = _fnameController.text;
                  widget.user.lastname = _lnameController.text;
                  widget.user.brand = _brandController.text;
                  widget.user.email = _mailController.text;
                  widget.user.address = _addressController.text;
                  widget.user.website = _websiteController.text;
                  widget.user.accountmanager = _accountManagerController.text;
                  widget.user.whatsapp = _whatsappController.text;
                  widget.user.instagram = _instagramController.text;
                  widget.user.facebook = _facebookController.text;
                  widget.user.twitter = _twitterController.text;
                  widget.user.linkedin = _linkedInController.text;
                  widget.user.pin = _pinController.text;

                  setState(() {
                    _lnameController.text = widget.user.lastname;
                  });

                  final uid = await Provider.of(context).auth.getCurrentUID();
                  await Provider.of(context)
                      .db
                      .collection('userData')
                      .document(uid)
                      .setData(widget.user.toJson());
                  showDialog(
                      context: context,
                      builder: (_) => CusDialog(
                            title: 'Profile Updated',
                            description: 'Profile Updated Successfully',
                            ontap: () {
                              Navigator.of(context).pop();
                              // Navigator.of(context)
                              //     .popUntil((route) => route.isFirst);
                            },
                          ));
                }
              })
        ],
      ),
      backgroundColor: white.withOpacity(0.9),
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          SizedBox(height: 10),
          Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, right: 12.0, left: 12.0),
                  child: CircleAvatar(
                      backgroundColor: white,
                      radius: 80,
                      backgroundImage: NetworkImage(
                          'https://www.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png')),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: white.withOpacity(0.5)),
                child: IconButton(
                    icon: Icon(Icons.person_add, size: 18), onPressed: () {}),
              )
            ],
          ),
          Column(
            children: <Widget>[
              buildEditUserForm(),
            ],
          ),
        ],
      )),
    );
  }

  Widget adminFeature() {
    if (_isAdmin == true) {
      return Text("You are an views.admin");
    } else {
      return Container();
    }
  }

  _getProfileData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .get()
        .then((result) {
      widget.user.firstname = result.data['firstname'];
      widget.user.lastname = result.data['lastname'];
      widget.user.brand = result.data['brand'];
      widget.user.email = result.data['email'];
      widget.user.address = result.data['address'];
      widget.user.website = result.data['website'];
      widget.user.accountmanager = result.data['accountmanager'];
      widget.user.whatsapp = result.data['whatsapp'];
      widget.user.instagram = result.data['instagram'];
      widget.user.facebook = result.data['facebook'];
      widget.user.twitter = result.data['twitter'];
      widget.user.linkedin = result.data['linkedin'];
    });
  }

  Widget displayUserInformation(BuildContext context, AsyncSnapshot snapshot) {
    final user = snapshot.data;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "${user.displayName ?? 'Anonymous'}",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
