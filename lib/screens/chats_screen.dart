import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(
              'chats/awjgYxlfNSrf3mvXBJ1v/messages')
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final docs =  streamSnapshot.data!.docs;
            print(docs[0]['text']);
            return ListView.builder(

              itemCount: docs.length,
              itemBuilder: (ctx, i) => Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(docs[i]['text']),
              ),
            );
          },
        )
    );
  }
}
