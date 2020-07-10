import 'package:brew_crew/Screens/home/chat.dart';
import 'package:brew_crew/Screens/home/profilePicture.dart';
import 'package:brew_crew/Screens/wrapper.dart';
import 'package:brew_crew/Services/auth.dart';
import 'package:brew_crew/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value (
      value: AuthService().user,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
    routes: {
      '/': (context) => wrapper(),
      '/chat': (context) => chat(),
      //'/location': (context) => choose_location(),

    }          
      ),
    );
  }
}
