import 'package:chatapp/constants.dart';
import 'package:chatapp/model/message.dart';
import 'package:chatapp/widget/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatApp extends StatelessWidget {
  ChatApp({super.key});
  static String id = 'ChatApp';

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(KCeatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];

          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromjson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: KPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    KLogo,
                    height: 50,
                  ),
                  const Text(
                    'Chat ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBubble(message: messagesList[index])
                          : ChatBubbleForFriend(
                              message: messagesList[index],
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      messages.add({
                        kMessage: value,
                        KCeatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();

                      _scrollController.animateTo(
                        0,
                        // _scrollController.position.maxScrollExtent,
                        curve: Curves.easeOut,
                        duration: Duration(
                          seconds: 1,
                        ),
                      );
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      suffix: const Icon(
                        Icons.send,
                        color: KPrimaryColor,
                      ),
                      hintText: "Send To Message",
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('loading..............');
        } else {
          return const Text('loading..............');
        }
      },
    );
  }
}
