import 'dart:io';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.msg,
    required this.isMe,
    required this.username,
    required this.img,
  }) : super(key: key);

  final String msg;
  final bool isMe;
  final String username;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
                width: 150,
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isMe
                      ? Colors.grey[300]
                      : Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: isMe
                        ? const Radius.circular(12)
                        : const Radius.circular(0),
                    bottomRight: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      msg,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                )),
          ],
        ),
        Positioned(
          left: isMe ? null : 125,
          right: isMe ? 125 : null,
          top: -15,
          child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              img,
            ),
          ),
        ),
      ],
    );
  }
}
