import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  void _sendMessage() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final username = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    print("mseeage : ----> $_msg");
    FirebaseFirestore.instance.collection('chat').add(
      {
        'text': _msg,
        'createdAt': Timestamp.now(),
        'sentBy' : userId,
        'username' : username['username'],
      },
    );
    _controller.clear();
  }

  var _msg = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              hintText: "Send message....",
            ),
            onChanged: (String value) {
              _msg = value;
            },
            controller: _controller,
          ),
        ),
        const SizedBox(width: 5),
        IconButton(
          onPressed: () => _msg.isEmpty ? null : _sendMessage(),
          icon: const Icon(
            Icons.send,
            color: Colors.teal,
          ),
        ),
      ],
    );
  }
}
