import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                reverse: true,
                itemBuilder: (context, index) => MessageBubble(
                  chatSnapshot.data.documents[index]['userName'],
                  chatSnapshot.data.documents[index]['userImage'],

                  chatSnapshot.data.documents[index]['text'],
                  chatSnapshot.data.documents[index]['userId'] ==
                      futureSnapshot.data.uid,
                  key: ValueKey(chatSnapshot.data.documents[index].documentID),
                ),
                itemCount: chatSnapshot.data.documents.length,
              );
            });
      },
    );
  }
}
