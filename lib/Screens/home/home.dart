import 'package:brew_crew/Screens/home/brew_list.dart';
import 'package:brew_crew/Screens/home/settings_bottomform.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/Services/auth.dart';
import 'package:brew_crew/Services/database.dart';
import 'package:provider/provider.dart';

class home extends StatelessWidget {
 final AuthService _auth= AuthService();
  @override
  Widget build(BuildContext context) {

      void _showSettingsPanel(){
        showModalBottomSheet(
          context: context, 
        builder: (context){
          return Container(
            padding:EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
            child: settingsForm(),
          );
        }
        );
      }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
          child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
             icon:Icon(Icons.person),
              label: Text('log out') ,
              onPressed: ()async{
                await _auth.SignOut();

              },),
              FlatButton.icon(
                 icon: Icon(Icons.settings),
                  label: Text('settings'),
                  onPressed: (){
                    _showSettingsPanel();
                  },)
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/coffee_bg.png'),
              fit: BoxFit.cover
              )
          ),
          child: brewList()
          
          ),
      ),
    );
  }
}