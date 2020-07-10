import 'package:brew_crew/Screens/authenticate/register.dart';
import 'package:brew_crew/Screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class authenticate extends StatefulWidget {
  @override
  _authenticateState createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {

bool showSignIn =true;
void toggleView(){
  setState(() {
    showSignIn = !showSignIn;
  });
}

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView);
    }
    else{
      return Register(toggleView: toggleView);
    }
      }
}