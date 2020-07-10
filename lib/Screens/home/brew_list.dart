import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/Screens/home/brew_tile.dart';
class brewList extends StatefulWidget {
  @override
  _brewListState createState() => _brewListState();
}

class _brewListState extends State<brewList> {
  @override
  Widget build(BuildContext context) {

    final brews= Provider.of<List<Brew>>(context) ?? [];
    //print(brews.documents);
//    for(var doc in brews.documents){
//      print(doc.data);

    

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context,index){
        return BrewTile(brew: brews[index]);
      } 
      );
  }
}