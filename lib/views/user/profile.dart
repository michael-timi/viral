import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viral/models/user.dart';
import 'package:viral/views/user/add_card.dart';
import 'file:///C:/Users/Michael%20Timi/AndroidStudioProjects/viral/edit_user.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/provider.dart';
import 'package:viral/widget/title.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user = User(null, null, null, null, null, null, null, null, null, null,
      null, null, null, null);
  final db = FirebaseFirestore.instance;
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

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: grey.withOpacity(0.15),
          elevation: 0,
          title: CustomText(
            text: 'ACCOUNT',
            color: black,
            fontWeight: FontWeight.bold,
            size: 13,
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditUserInfo(user: user)));
              },
            )
          ],
        ),
        backgroundColor: grey.withOpacity(0.2),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                FutureBuilder(
                  future: Provider.of(context).auth.getCurrentUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return displayUserInformation(context, snapshot);
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }

  Widget adminFeature() {
    if (_isAdmin == true) {
      return Text("You are an admin");
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
      user.firstname = result.data()['firstname'];
      user.lastname = result.data()['lastname'];
      user.brand = result.data['brand'];
      user.email = result.data()['email'];
      user.address = result.data['address'];
      user.website = result.data['website'];
      user.accountmanager = result.data['accountmanager'];
      user.whatsapp = result.data['whatsapp'];
      user.instagram = result.data['instagram'];
      user.facebook = result.data['facebook'];
      user.twitter = result.data['twitter'];
      user.linkedin = result.data['linkedin'];
    });
  }

  Widget displayUserInformation(context, snapshot) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    //views.user firebase db
    final authData = snapshot.data;

    return Column(
      children: <Widget>[
        SizedBox(height: height * 0.01),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 12.0, left: 12.0),
            child: CircleAvatar(
              backgroundColor: white,
              radius: 60,
              backgroundImage: NetworkImage(
                  'https://www.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${authData.phoneNumber ?? 'User'}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(
        //       left: 8.0, right: 8.0, bottom: 8.0, top: 4.0),
        //   child: Text(
        //     "Created: ${DateFormat('dd/MM/yyyy').format(authData.metadata.creationTime)}",
        //     style: TextStyle(fontSize: 16),
        //   ),
        // ),
        FutureBuilder(
            future: _getProfileData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                _fnameController.text = user.firstname;
                _lnameController.text = user.lastname;
                _mailController.text = user.email;
                _isAdmin = user.admin ?? false;
              }
              return Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: Text(
                        "${_fnameController.text}" +
                            ' ${_lnameController.text}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: Text(
                        "${_mailController.text}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              );
            }),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: height * 0.03,
            width: width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    icon: Icon(FontAwesomeIcons.whatsapp), onPressed: () {}),
                IconButton(
                    icon: Icon(FontAwesomeIcons.instagram), onPressed: () {}),
                IconButton(
                    icon: Icon(FontAwesomeIcons.facebook), onPressed: () {}),
                IconButton(
                    icon: Icon(FontAwesomeIcons.twitter), onPressed: () {}),
                IconButton(
                    icon: Icon(FontAwesomeIcons.linkedin), onPressed: () {}),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     InkWell(
        //       child: Container(
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(4),
        //             border: Border.all(color: black, width: 1)),
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(
        //               horizontal: 56.0, vertical: 4.0),
        //           child: CustomText(text: 'Email'),
        //         ),
        //       ),
        //       onTap: () {},
        //     ),
        //     SizedBox(width: 10),
        //     InkWell(
        //       child: Container(
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(4),
        //             border: Border.all(color: black, width: 1)),
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(
        //               horizontal: 56.0, vertical: 4.0),
        //           child: CustomText(text: 'Phone'),
        //         ),
        //       ),
        //       onTap: () {},
        //     ),
        //   ],
        // ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomText(text: 'Account Manager:', color: grey),
            SizedBox(width: 20),
            CustomText(text: 'Joshua IGBA', color: grey),
          ],
        ),
        SizedBox(height: 10),
        InkWell(
          child: Container(
            height: height * 0.2,
            width: width * 0.72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 3)
              ],
              color: white,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, right: 24.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: CustomText(
                          text: 'Add Card',
                          fontWeight: FontWeight.bold,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserCard()));
                        },
                      )),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                      child: Container(
                          height: height * 0.035,
                          child: Image.asset('assets/cardchip.png')),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: CustomText(
                        text: 'XXXX XXXX XXXX XXXX XXX',
                        color: black,
                        size: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                      child: CustomText(
                        text: 'MM/YY',
                        color: black,
                        size: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, top: 5.0),
                      child: Container(
                          height: height * 0.04,
                          child: Image.asset('assets/mastercard.png')),
                    ),
                  ],
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UserCard()));
          },
        ),
        SizedBox(height: 10),
        Container(
          height: height * 0.05,
          width: width * 0.72,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0), color: white),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomText(text: 'XXXX XXXX XXXX XXXX 1477', size: 18),
                SizedBox(width: 15),
                Icon(
                  Icons.radio_button_checked,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: height * 0.15),
        showSignOut(context, authData.isAnonymous),
      ],
    );
  }

  Widget showSignOut(context, bool isAnonymous) {
    if (isAnonymous == true) {
      return RaisedButton(
        child: Text("Sign In To Save Your Data"),
        onPressed: () {
          Navigator.of(context).pushNamed('/convertUser');
        },
      );
    } else {
      return IconButton(
        icon: Icon(
          FontAwesomeIcons.signOutAlt,
          color: black,
        ),
        onPressed: () async {
          try {
            await Provider.of(context).auth.signOut();
          } catch (e) {
            print(e);
          }
        },
      );
    }
  }
}
