import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_dudes/module/authentication.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Authentication(),
        )
      ],
      child: MaterialApp(
        title: 'FOOD DUDES',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _MyHomePageState extends State<MyHomePage> {


  Color primaryColor=Color(0xff18203d);
  Color secondaryColor=Color(0xff232c51);
  Color logoGreen=Color(0xff25bcbb);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text('Food Dudes'),
      ),
      backgroundColor: primaryColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //We take the image from the assets
            Image.asset(
              "assets/logo.png",
              height: 400, width: 500,
            ),
            SizedBox(
              height: 20,
            ),
            //Our MaterialButton which when pressed will take us to a new screen named as
            //LoginScreen
            MaterialButton(
              elevation: 0,
              height: 50,
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SignUp()) );
              },
              color: logoGreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              textColor: Colors.white,
            )
          ],
        ),
      ),
      );// This trailing comma makes auto-formatting nicer for build methods.
  }
  }