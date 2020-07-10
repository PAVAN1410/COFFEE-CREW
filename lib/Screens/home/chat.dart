import 'package:flutter/material.dart';
import 'package:path/path.dart';

class chat extends StatefulWidget {
  @override
  _chatState createState() => _chatState();
}

class _chatState extends State<chat> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.blue[400],
      //bottomNavigationBar: BottomNavigationBar(items: ),
      appBar: AppBar(
        title: Text('chat'),
        backgroundColor: Colors.blue[200],
      ),
      body: RaisedButton(onPressed: null),
    );
  }
}