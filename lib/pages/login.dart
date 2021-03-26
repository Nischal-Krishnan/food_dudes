import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_dudes/module/authentication.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'signup.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

Color primaryColor=Color(0xff18203d);
Color secondaryColor=Color(0xff232c51);
Color logoGreen=Color(0xff25bcbb);

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _loginState extends State<login> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email' : '',
    'password': ''
  };

  void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }

  Future<void> _submit() async
  {

    if(!_formKey.currentState.validate())
    {
      return;
    }
    _formKey.currentState.save();

    try{
      await Provider.of<Authentication>(context, listen: false).logIn(
          _authData['email'],
          _authData['password']
      );
      Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));

    } catch (error)
    {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
           children: <Widget>[
            Column(
            children: [
                  Text(
                  'Sign Up ',
                  textAlign: TextAlign.center,
                  style:
                  GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(height: 20),
                Text(
                'Enter your email and password below to continue.',
                textAlign: TextAlign.center,
                style:
                GoogleFonts.openSans(color: Colors.white, fontSize: 14),

                ),
                SizedBox(height: 50,),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                   child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                     child: Column(
                        children: <Widget>[

                      buildEmailFields('Email', Icons.email_rounded),
                      SizedBox(height: 8),
                      buildPasswordFields( 'Password', Icons.lock_outline_rounded),
                      SizedBox(height: 8),
                      MaterialButton(
                        elevation: 0,
                        minWidth: double.maxFinite,
                        height: 50,
                        onPressed: () async{
                        _submit();
                        //Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
                        },
                        color: logoGreen,
                        child: Text('Sign in',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 20),
                       MaterialButton(
                         elevation: 0,
                         minWidth: double.maxFinite,
                         height: 50,
                         onPressed: () async{
                           Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
                          final GoogleSignInAccount googleUser = await googleSignIn.signIn();
                          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                          //final AuthCredential credential = GoogleAuthProvider.getCredential(
                          //idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

                          // ignore: unused_local_variable
                          //final FirebaseUser user = (await firebaseAuth.signInWithCredential(credential)).user;
                          },
                          color: Colors.blue,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                              Icon(FontAwesomeIcons.google),
                              SizedBox(width: 10),
                              Text('Sign-in using Google',
                                style: TextStyle(color: Colors.white, fontSize: 16)),
                              ],
                          ),
                          textColor: Colors.white,
                      ),
                      SizedBox(height: 8),
                      TextButton(
                        style: TextButton.styleFrom(
                        primary: Colors.white,
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => SignUp()));
                          },
                        child: Text("Don't have an account? Sign up")
                        ),
                        SizedBox(height: 100),
                      ],
                     ),
                    ),
                   ),
                  ),
                ),
                ],
            ),
      ],
      ),
    );
  }


  buildEmailFields(String labelText, IconData icon){
    return Container(

      decoration: BoxDecoration(
          color: secondaryColor,
          border:Border.all(color: Colors.blue)),
      child: TextFormField(
          validator: (value)
          {if(value.isEmpty || !value.contains('@')) {
            return 'invalid email';
          }
          return null;
          },
          onSaved: (value) {
            _authData['email'] = value;
          },
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
          )
      ),
    );
  }

  buildPasswordFields(String labelText, IconData icon){
    return Container(

      decoration: BoxDecoration(
          color: secondaryColor,
          border:Border.all(color: Colors.blue)),
      child: TextFormField(
          validator: (value)
          {
            if(value.isEmpty || value.length<=5)
            {
              return 'invalid password';
            }
            return null;
          },
          onSaved: (value)
          {
            _authData['password'] = value;
          },
          style: TextStyle(color: Colors.white),
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
          )
      ),
    );
  }

}
