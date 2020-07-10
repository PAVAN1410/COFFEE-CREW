import 'package:brew_crew/Services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();// (toggleView: toggleView);
}

class _SignInState extends State<SignIn> {
//  final Function toggleView;
//_SignInState({this.toggleView});

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email='';
  String password ='';
  String error ='';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(  
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('sign in to vitmas'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
             label: Text('Register'),
             onPressed: (){
               widget.toggleView();
             })
        ],
      ),
      body: 
        ListView(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          children: <Widget>[
            Form(
            key: _formkey,
            child: Column(
            children: <Widget>[
              SizedBox(height:20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
               validator: (val){
                return val.isEmpty ? 'Enter an email' : null;
               },
                onChanged: (val){
                  setState(() {
                    email= val;
                  });

                },
              ),
              SizedBox(height:20.0),
              
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
               validator: (val){
                return val.length<6 ? 'Enter a password of length >6' : null;
               },
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password=val;
                  });

                },
              ),
              SizedBox(height:20.0),
              RaisedButton(
                color: Colors.blue[400],
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed:() async
                {
                  if(_formkey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result= await _auth.signInWithEmailAndPassword(email, password);
                    if(result== null){
                      setState(() {
                        loading = false;
                        error= 'please enter valid credintials';
                      });
                    }
                  }

                },
                
                ),
              SizedBox(height: 5.0),
                Text(error,
                style:TextStyle(
                  color: Colors.red,fontSize: 13.0
                ) ,
                ),
          ],
          ),
          ),
          ],
        )
        
    );
  }
}