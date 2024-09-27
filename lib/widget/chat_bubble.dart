import 'package:chatapp/constants.dart';
import 'package:chatapp/model/message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({
    super.key,
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        // alignment: Alignment.centerLeft,
        padding:
            const EdgeInsets.only(left: 16, bottom: 32, top: 32, right: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: KPrimaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  ChatBubbleForFriend({
    super.key,
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        // alignment: Alignment.centerLeft,
        padding:
            const EdgeInsets.only(left: 16, bottom: 32, top: 32, right: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: Color(0xff006D84),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
