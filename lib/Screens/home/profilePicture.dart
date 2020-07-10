import 'dart:io';

import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class profilePicture extends StatefulWidget {
  @override
  _profilePictureState createState() => _profilePictureState();
}

class _profilePictureState extends State<profilePicture> {
  File imageFile;
  bool inprocess = false;
  @override

  Widget build(BuildContext context) {

  Future getImage() async{
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      
    setState(() {
      imageFile =image;
      print('Image path $imageFile');
    });
  }

  Future uploadPicture(BuildContext context) async{
    String fileName = basename(imageFile.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('upload success'),));
    });

  }
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('Edit profile '),
      ),
      body: Builder(
        builder: (context)=> Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.yellowAccent,
                      child: ClipOval(
                        child: SizedBox(
                          width:180.0,
                          height: 180.0,
                          child: (imageFile != null)? Image.file(imageFile,fit: BoxFit.fill) :
                          Container(
                            color: Colors.red,
                            child: Center(
                              child: Text('Image placeholder'
                              ,style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0
                              ),),
                            ),
                          ), 
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      size: 30.0,),
                       onPressed:(){
                         getImage();
                       }
                       )
                ],

              ),
              SizedBox(height:20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                    alignment: Alignment.centerLeft,
                    child: Text('user name'
                    ,style: TextStyle(
                      fontSize: 25.0

                    ),) ,
                    ),
                    Align(
                    alignment: Alignment.centerLeft,
                    child: Text(' Pavan ',style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,

                    ),) ,
                    ),
                    ],
                    ),
                    ),
                    
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue,
                      size: 20.0,),
                       onPressed: null),
                ],
              ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: (){},
                child: Text('cancle'),
                color: Colors.blue,
                splashColor: Colors.red,
                ),

                RaisedButton(
                  
                  onPressed: (){
                    uploadPicture(context);
                  },
                
                child: Text('save'),)
              ],

            )
            ],
          ),
        )),

    );
  }
}