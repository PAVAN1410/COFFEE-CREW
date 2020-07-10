import 'package:brew_crew/Services/database.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class settingsForm extends StatefulWidget {
  @override
  _settingsFormState createState() => _settingsFormState();
}

class _settingsFormState extends State<settingsForm> {
  
  final _formKey =GlobalKey<FormState>();
  final List<String> sugars= ['0','1','2','3','4'];
  bool inprocess = false;

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
        final user =Provider.of<User>(context);
        print(user.uid);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      
      builder: (context, snapshot) {
        //print(snapshot);
        if(snapshot.hasData){
          UserData userData =snapshot.data;
         // print(userData.uid);
          //print(userData.sugars);
          return Stack(
                      children: <Widget>[
                         Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Text(
                    'update your brew settings',
                    style: TextStyle(fontSize: 15.0,),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration.copyWith(hintText: 'Name', fillColor: Colors.brown[300]),

                      validator: (val) => val.isEmpty ? 'please enter a name' : null,
                      onChanged: (val) => setState(()=> _currentName=val),
                    ),
                    SizedBox(height: 20.0,),
                  
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'sugar', fillColor: Colors.brown[300]),
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar){
                      return DropdownMenuItem(
                        value: sugar,
                        child:Text('$sugar sugars') ,
                        );
                    }).toList(),

                    onChanged: (val) => setState(()=> _currentSugars=val),
                  ),

                  //Slider
                  Slider(
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) => setState(() =>_currentStrength = val.round()),
                    value: (_currentStrength ?? userData.strength).toDouble() ,
                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  ),

                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                      ),

                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        setState(() {
                          inprocess = true;
                        });
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ??userData.sugars,    //sugars,
                          _currentName ?? userData.name,       //name,
                          _currentStrength ?? userData.strength// strength
                           );
                           setState(() {
                             inprocess = false;
                           });

                           Navigator.pop(context);
                      }
                    })
                ],
              ),
              
            ),
               (inprocess)?Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ):Center()

        ],
      
      );
        }

        else{
          Loading();
        }
        
        
      }
    );
  }
}