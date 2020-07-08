import 'package:flutter/material.dart';
import 'package:chatify/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {

  static String id ='chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth=FirebaseAuth.instance;
  final _firestore=Firestore.instance;
  FirebaseUser loggedinUser;
  String messagetext;

  void getcurrentUser()async{

    try {
      final user=await _auth.currentUser();

      if (user!=null){
       loggedinUser=user;

      }
    }catch(e){
      print(e);
    }

  }
  void getmessages()async{
     await for( var snapshots in  _firestore.collection('messages').snapshots()) {
    for (var message in snapshots.documents) {
      print(message.data);
    }
     }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('💬 Chats'),
        backgroundColor: Color.fromRGBO(246, 160, 160,1),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(stream:  _firestore.collection('messages').snapshots() ,
            builder: (context,snapshot){
              if (snapshot.hasData){
                final messages =snapshot.data;
              }

            },),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.redAccent, width: 3.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messagetext=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                     _firestore.collection('messages').add({
                       'text':messagetext,
                       'sender':loggedinUser.email,
                     });
                    },
                    child: Text(
                      'Send >>',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}