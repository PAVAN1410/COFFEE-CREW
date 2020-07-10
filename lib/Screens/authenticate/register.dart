import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/Services/auth.dart';
import 'package:brew_crew/shared/constants.dart';


class Register extends StatefulWidget {
   final Function toggleView;
   Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();  // * (toggleView: toggleView);
}

class _RegisterState extends State<Register> {
    final AuthService _auth = AuthService();
      bool loading = false;

  // *  final Function toggleView;
  // *  _RegisterState({this.toggleView});

  final _formKey =GlobalKey<FormState>();
 
 // text field state
  String email='';
  String password ='';
  String error ='';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(  
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Register to vitmas'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
             label: Text('Sign in'),
             onPressed: (){
              // * toggleView();
              widget.toggleView();
               
             })
        ]
      ),
      body: 
        ListView(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          children: <Widget>[
            Form(
            key: _formKey,
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
                color: Colors.blue[300],//.green[600],
                child: Text(
                  'register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed:() async
                {
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result= await _auth.registerWithEmailAndPassword(email, password);
                    if(result== null){
                      //setState(() => error= 'please enter a valid email' );
                      setState(() {
                        error= 'please enter a valid email';
                        loading = false;
                      });
                    }                  
                  }
                },),
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
        ,
    );
  }
}