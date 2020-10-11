import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:viral/models/campaign.dart';
import 'package:viral/models/card_model.dart';
import 'package:viral/widget/button.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/input_formatter.dart';
import 'package:viral/widget/title.dart';
import 'package:viral/widget/utils.dart';

class CampaignPayment extends StatefulWidget {
  final Campaigns campaigns;

  CampaignPayment({Key key, this.campaigns}) : super(key: key);
  @override
  _CampaignPaymentState createState() => _CampaignPaymentState();
}

class _CampaignPaymentState extends State<CampaignPayment> {
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  bool isCvvFocused = false;
  Color themeColor;

  final _formKey = GlobalKey<FormState>();
  final _cardNumber = TextEditingController();
  final _cardHolder = TextEditingController();
  final _expDate = TextEditingController();
  final _cvv = TextEditingController();
  bool loading = false;
  FocusNode cvvFocusNode = FocusNode();

  void onCardModelChange(CardModel cardModel) {
    setState(() {
      _cardNumber.text = cardModel.cardNumber;
      _expDate.text = cardModel.expiryDate;
      _cardHolder.text = cardModel.cardHolderName;
      _cvv.text = cardModel.cvvCode;
      isCvvFocused = cardModel.isCvvFocused;
    });
  }

  void textFieldFocusDidChange(CardModel cardModel) {
    cardModel.isCvvFocused = cvvFocusNode.hasFocus;
    onCardModelChange(cardModel);
  }

  void createCardModel(CardModel cardModel) {
    cardNumber = cardNumber ?? '';
    expiryDate = expiryDate ?? '';
    cardHolderName = cardHolderName ?? '';
    cvvCode = cvvCode ?? '';

    cardModel = CardModel(
        cardNumber, expiryDate, cardHolderName, cvvCode, isCvvFocused);
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      _cardNumber.text = creditCardModel.cardNumber;
      _expDate.text = creditCardModel.expiryDate;
      _cardHolder.text = creditCardModel.cardHolderName;
      _cvv.text = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  void initState() {
    PaystackPlugin.initialize(
        publicKey: "pk_live_71632e427985331ff0ce7b7e139348797e61f2ae");
    super.initState();
  }

  Dialog successDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Container(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_box,
                color: hexToColor("#41aa5e"),
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Payment has successfully',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'been made',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "Your payment has been successfully",
                style: TextStyle(fontSize: 13),
              ),
              Text("processed.", style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return successDialog(context);
      },
    );
  }

  Dialog errorDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Container(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Failed to process payment',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "Error in processing payment, please try again",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return errorDialog(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int campaignPrice = widget.campaigns.price;

    handleBeforeValidate(Transaction transaction) {
      print(transaction.message);
    }

    handleOnSuccess(Transaction transaction) {
      loading = false;
      setState(() => {});
      print("success");
      _showDialog();
    }

    handleOnError(Object error, Transaction transaction) {
      loading = false;
      setState(() => {});
      print("error");
      _showErrorDialog();
    }

    PaymentCard _getCardFromUI() {
      List spiltDates = _expDate.text.split("/");
      return PaymentCard(
        number: getCleanedNumber(_cardNumber.text),
        cvc: _cvv.text,
        expiryMonth: int.parse(spiltDates[0]),
        expiryYear: int.parse(spiltDates[1]),
      );
    }

    String _getReference() {
      String platform;
      if (Platform.isIOS) {
        platform = 'iOS';
      } else {
        platform = 'Android';
      }
      return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
    }

    _chargeCard(String reference, int amount) async {
      var charge = Charge()
        ..amount = amount
        ..email = "dntv@gmail.com"
        ..reference = reference
        ..card = _getCardFromUI();

      await PaystackPlugin.chargeCard(context,
          charge: charge,
          beforeValidate: (transaction) => handleBeforeValidate(transaction),
          onSuccess: (transaction) => handleOnSuccess(transaction),
          onError: (error, transaction) => handleOnError(error, transaction));
    }

    Widget cardNumber = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Card Number",
        border: InputBorder.none,
      ),
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      controller: _cardNumber,
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
        new LengthLimitingTextInputFormatter(19),
        new CardNumberInputFormatter()
      ],
      validator: validateCardNumWithLuhnAlgorithm,
    );

    Widget expDate = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: 'MM/YY',
        border: InputBorder.none,
      ),
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
        new LengthLimitingTextInputFormatter(4),
        new CardMonthInputFormatter()
      ],
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      controller: _expDate,
      validator: validateDate,
    );

    Widget cvv = TextFormField(
        obscureText: false,
        decoration: InputDecoration(
          hintText: "CVV",
          border: InputBorder.none,
        ),
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          new LengthLimitingTextInputFormatter(4),
        ],
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        controller: _cvv,
        validator: validateCVV);

    Widget buildForms() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: white),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: cardNumber,
                    decoration: BoxDecoration(
                        color: hexToColor("#F5F6FA"),
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: expDate,
                          decoration: BoxDecoration(
                              color: hexToColor("#F5F6FA"),
                              borderRadius: BorderRadius.circular(4))),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: cvv,
                          decoration: BoxDecoration(
                              color: hexToColor("#F5F6FA"),
                              borderRadius: BorderRadius.circular(4))),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'ENTER CARD DETAILS',
          color: white,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                print(widget.campaigns.price);
                print(campaignPrice);
              })
        ],
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: white.withOpacity(0.95),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          margin:
          EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CreditCardWidget(
                cardNumber: _cardNumber.text,
                cardHolderName: _cardHolder.text,
                cvvCode: _cvv.text,
                expiryDate: _expDate.text,
                showBackView: isCvvFocused,
              ),
              // Expanded(
              //     child: SingleChildScrollView(
              //   child: CreditCardForm(
              //       onCreditCardModelChange: onCreditCardModelChange),
              // )),
              buildForms(),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: Button(
                  child: Text(loading ? "PAYING..." : "PAY",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                  onClick: () async {
                    if (_formKey.currentState.validate() && !loading) {
                      setState(() {
                        loading = true;
                      });
                      var reference = _getReference();
                      await _chargeCard(reference, campaignPrice * 100);
                      // Navigator.of(context)
                      //     .popUntil((route) => route.isFirst);
                    }
                  },
                ),
              )
            ],
          ),),
      ),
    );
  }
}
