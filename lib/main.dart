import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viral/services/auth_service.dart';
import 'package:viral/views/first_view.dart';
import 'package:viral/views/locations/location.dart';
import 'package:viral/views/verify_login.dart';
import 'package:viral/views/viral_pages.dart';
import 'package:viral/widget/provider.dart';

//This is Josh Comment

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      db: FirebaseFirestore.instance,
      auth: AuthService(),
      child: MaterialApp(
        title: 'Viral',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xff19289f),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: TextTheme(
                bodyText1: GoogleFonts.montserrat(),
                bodyText2: GoogleFonts.montserrat())),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeController(),
          '/signUp': (BuildContext context) =>
              SignUpView(authFormType: AuthFormType.signUp),
          '/signIn': (BuildContext context) =>
              SignUpView(authFormType: AuthFormType.phone),
          '/welcome': (BuildContext context) => FirstView(),
          '/location': (BuildContext context) => Location(),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? ViralPages() : FirstView();
        }
        return Container();
      },
    );
  }
}
