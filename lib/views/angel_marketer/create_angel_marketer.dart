import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:viral/models/angel_marketer.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/custom_dialog.dart';
import 'package:viral/widget/title.dart';

class CreateAngelMarketer extends StatefulWidget {
  final AngelMarketer angelMarketer;
  final GlobalKey<ScaffoldState> globalKey;
  CreateAngelMarketer({Key key, this.globalKey, this.angelMarketer})
      : super(key: key);
  @override
  _CreateAngelMarketerState createState() => _CreateAngelMarketerState();
}

class _CreateAngelMarketerState extends State<CreateAngelMarketer> {
  String name, phone, bank, accountNo, mail;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //firebase
    final db = FirebaseFirestore.instance;

    //current date
    DateTime _createdDate = DateTime.now();
    var year = DateFormat('yy').format(_createdDate).toString();
    var month = DateFormat('MM').format(_createdDate).toString();

    String dayMonth = month + year;
    var rnd = Random();
    var rndno = rnd.nextInt(9000) + 1000;

    String randomID = dayMonth + rndno.toString();

    String status = 'Pending';
    // ignore: unused_local_variable
    var dt = DateFormat.yMMMMEEEEd().format(DateTime.now());

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _bankController = TextEditingController();
    TextEditingController _accountNoController = TextEditingController();
    TextEditingController _phoneController = TextEditingController();
    TextEditingController _mailController = TextEditingController();
    TextEditingController _statusController = TextEditingController();
    _statusController.text = widget.angelMarketer.status;
    _bankController.text = widget.angelMarketer.bank;
    _accountNoController.text = widget.angelMarketer.accountNo;
    _mailController.text = widget.angelMarketer.mail;
    _nameController.text = widget.angelMarketer.name;
    _phoneController.text = widget.angelMarketer.phone;

    Widget amName = TextFormField(
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

    Widget amBank = TextFormField(
      controller: _bankController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Bank',
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
          return 'Bank is Required';
        }

        return null;
      },
      onSaved: (String value) {
        bank = value;
      },
    );

    Widget amAccountNo = TextFormField(
      controller: _accountNoController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Account No',
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
          return 'Account No is Required';
        } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
          // No need to even proceed with the validation if it's less than 8 characters
          return "Card is not valid.";
        }

        return null;
      },
      onSaved: (String value) {
        accountNo = value;
      },
    );

    Widget amEmail = TextFormField(
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

    Widget amPhone = TextFormField(
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
        } else if (!RegExp(r'^(234)?[0-9]{10}$').hasMatch(value)) {
          return 'Invalid phone number';
        }

        return null;
      },
      onSaved: (String value) {
        phone = value;
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
                        text: 'ACCOUNT INFORMATION',
                        color: black,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: amName,
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  child: amEmail,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: amPhone,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.business_center),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          print(dayMonth + rndno.toString());
                        },
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: 'BANK DETAILS',
                        color: black,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: amBank,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: amAccountNo,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('CREATE ANGEL MARKETER'),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(Icons.save),
            ),
            onTap: () async {
              print(_statusController.text);
              if (!_formKey.currentState.validate()) {
                return;
              } else {
                _statusController.text = status;
                print(_nameController.text);
                print(_mailController.text);
                print(_phoneController.text);
                print(_bankController.text);
                print(_accountNoController.text);
                print(_statusController.text);

                widget.angelMarketer.id = randomID;
                widget.angelMarketer.name = _nameController.text;
                widget.angelMarketer.mail = _mailController.text;
                widget.angelMarketer.phone = _phoneController.text;
                widget.angelMarketer.bank = _bankController.text;
                widget.angelMarketer.accountNo = _accountNoController.text;
                widget.angelMarketer.createdAt = _createdDate;
                widget.angelMarketer.status = 'Pending';

                //save to firebase
                await db
                    .collection("angelMarketers")
                    .add(widget.angelMarketer.toJson());

                showDialog(
                    context: context,
                    builder: (_) => CusDialog(
                          title: 'Success',
                          description: 'Angel Marketer Created Successfully',
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
          ],
        ),
      ),
    );
  }
}
