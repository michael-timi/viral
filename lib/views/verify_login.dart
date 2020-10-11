import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:viral/services/auth_service.dart';
import 'package:viral/widget/colors.dart';
import 'package:viral/widget/provider.dart';

enum AuthFormType { signIn, signUp, reset, anonymous, convert, phone }

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;

  SignUpView({Key key, @required this.authFormType}) : super(key: key);

  @override
  _SignUpViewState createState() =>
      _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {
  AuthFormType authFormType;

  _SignUpViewState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _email, _password, _name, _warning, _phone;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else if (state == 'home') {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacementNamed('/welcome');
      // setState(() {
      //   authFormType = AuthFormType.phone;
      // });
    }
  }

  bool validate() {
    final form = formKey.currentState;
    if (authFormType == AuthFormType.anonymous) {
      return true;
    }
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        switch (authFormType) {
          case AuthFormType.signIn:
            await auth.signInWithEmailAndPassword(_email, _password);
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case AuthFormType.signUp:
            await auth.createUserWithEmailAndPassword(_email, _password, _name);
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case AuthFormType.reset:
            await auth.sendPasswordResetEmail(_email);
            _warning = "A password reset link has been sent to $_email";
            setState(() {
              authFormType = AuthFormType.signIn;
            });
            break;
          case AuthFormType.anonymous:
            await auth.singInAnonymously();
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case AuthFormType.convert:
            await auth.convertUserWithEmail(_email, _password, _name);
            Navigator.of(context).pop();
            break;
          case AuthFormType.phone:
            var result = await auth.createUserWithPhone(_phone, context);
            if (_phone == "" || result == "error") {
              setState(() {
                _warning = "Your phone number could not be validated";
              });
            }
            break;
        }
      } catch (e) {
        print(e);
        setState(() {
          _warning = e.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    if (authFormType == AuthFormType.anonymous) {
      submit();
      return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SpinKitDoubleBounce(
                  color: Colors.white,
                ),
                Text(
                  "Loading",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          leading: IconButton(
              icon:
              Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/welcome');
              }),
        ),
        body: SafeArea(
            child: ListView(
              children: <Widget>[
                Container(
                  color: white,
                  height: _height,
                  width: _width,
                  child: SafeArea(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: _height * 0.05),
                        showAlert(),
                        SizedBox(height: _height * 0.1),
                        Container(
                          height: _height * 0.1,
                          child: Image.asset('assets/viral.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 10, bottom: 20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: buildInputs() + buildButtons(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      );
    }
  }

  Widget showAlert() {
    if (_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _warning,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.signIn) {
      _headerText = "Sign In";
    } else if (authFormType == AuthFormType.reset) {
      _headerText = "Reset Password";
    } else if (authFormType == AuthFormType.phone) {
      _headerText = "Phone Sign In";
    } else {
      _headerText = "Create New Account";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 35,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      _phone = internationalizedPhoneNumber;
    });
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    // if were in the sign up state add name
    if ([AuthFormType.signUp, AuthFormType.convert].contains(authFormType)) {
      textFields.add(
        TextFormField(
          validator: NameValidator.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildSignUpInputDecoration("Name", ''),
          onSaved: (value) => _name = value,
        ),
      );
      textFields.add(SizedBox(height: 20));
    }

    // add email & password
    if ([
      AuthFormType.signUp,
      AuthFormType.convert,
      AuthFormType.reset,
      AuthFormType.signIn
    ].contains(authFormType)) {
      textFields.add(
        TextFormField(
          validator: EmailValidator.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildSignUpInputDecoration("Email", ''),
          onSaved: (value) => _email = value,
        ),
      );
      textFields.add(SizedBox(height: 20));
    }
    if (authFormType != AuthFormType.reset &&
        authFormType != AuthFormType.phone) {
      textFields.add(
        TextFormField(
          validator: PasswordValidator.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildSignUpInputDecoration("Password", ''),
          obscureText: true,
          onSaved: (value) => _password = value,
        ),
      );
      textFields.add(SizedBox(height: 20));
    }

    if (authFormType == AuthFormType.phone) {
      textFields.add(
//        TextFormField(
//          style: TextStyle(fontSize: 22.0),
//          decoration: buildSignUpInputDecoration("Enter Phone"),
//          onSaved: (value) => _phone = value,
//        ),
        InternationalPhoneInput(
            decoration: buildSignUpInputDecoration(
                "e.g 8123456789", 'Enter Phone Number'),
            onPhoneNumberChange: onPhoneNumberChange,
            initialPhoneNumber: _phone,
            initialSelection: 'US',
            showCountryCodes: true),
      );
      textFields.add(SizedBox(height: 20));
    }

    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint, label) {
    return InputDecoration(
      labelText: label,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.grey[200])),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.grey)),
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[100],
      focusColor: Colors.white,
      contentPadding:
      const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
    );
  }

  List<Widget> buildButtons() {
    final height = MediaQuery.of(context).size.height;
    String _switchButtonText, _newFormState, _submitButtonText;
    bool _showForgotPassword = false;
    bool _showSocial = true;

    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = "Create New Account";
      _newFormState = "signUp";
      _submitButtonText = "Sign In";
      _showForgotPassword = true;
    } else if (authFormType == AuthFormType.reset) {
      _switchButtonText = "Return to Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Submit";
      _showSocial = false;
    } else if (authFormType == AuthFormType.convert) {
      _switchButtonText = "Cancel";
      _newFormState = "home";
      _submitButtonText = "Sign Up";
    } else if (authFormType == AuthFormType.phone) {
      _switchButtonText = "";
      _newFormState = "signIn";
      _submitButtonText = "Verify";
      _showSocial = false;
    } else {
      _switchButtonText = "Have an Account? Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Sign Up";
    }

    return [
      Padding(
        padding: const EdgeInsets.only(top: 300),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            color: Theme.of(context).primaryColor,
            textColor: white,
            child: Text(
              _submitButtonText,
              style: TextStyle(fontSize: 15.0),
            ),
            onPressed: submit,
          ),
        ),
      ),
      showForgotPassword(_showForgotPassword),
      FlatButton(
        child: Text(
          _switchButtonText,
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
        ),
        onPressed: () {
          switchFormState(_newFormState);
        },
      ),
      buildSocialIcons(_showSocial),
    ];
  }

  Widget showForgotPassword(bool visible) {
    return Visibility(
      child: FlatButton(
        child: Text(
          "Forgot Password?",
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
        ),
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.reset;
          });
        },
      ),
      visible: visible,
    );
  }

  Widget buildSocialIcons(bool visible) {
    final _auth = Provider.of(context).auth;
    return Visibility(
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.white,
          ),
          SizedBox(height: 10),
          GoogleSignInButton(
            onPressed: () async {
              try {
                if (authFormType == AuthFormType.convert) {
                  await _auth.convertWithGoogle();
                  Navigator.of(context).pop();
                } else {
                  await _auth.signInWithGoogle();
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              } catch (e) {
                setState(() {
                  print(e);
                  _warning = e.message;
                });
              }
            },
          ),
          RaisedButton(
            color: Colors.green,
            textColor: Colors.white,
            child: Row(
              children: <Widget>[
                Icon(Icons.phone),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14.0, top: 10.0, bottom: 10.0),
                  child: Text("Sign in with Phone",
                      style: TextStyle(fontSize: 18)),
                )
              ],
            ),
            onPressed: () {
              setState(() {
                authFormType = AuthFormType.phone;
              });
            },
          )
        ],
      ),
      visible: visible,
    );
  }
}
