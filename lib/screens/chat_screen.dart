import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('/chats/ueY2ULSZNjepWFsPh188/messages')
            .snapshots(),
        builder: (ctx, latestSnapshot) {
          if (latestSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          QuerySnapshot querySnapshot = latestSnapshot.data;
          return ListView.builder(
            itemCount: querySnapshot.docs.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(querySnapshot.docs[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('/chats/ueY2ULSZNjepWFsPh188/messages')
              .add({
            'text': 'This was added by clicking the button',
          });
        },
      ),
    );
  }
}
