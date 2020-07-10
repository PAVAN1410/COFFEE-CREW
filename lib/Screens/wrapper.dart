import 'package:brew_crew/Screens/home/home.dart';
import 'package:brew_crew/models/user.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/Screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';


class wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user =Provider.of<User>(context);
    print(user);
    // return either home or authenticate
    if(user==null)
    return authenticate();
    else
    return home();

  }
}