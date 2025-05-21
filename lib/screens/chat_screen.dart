import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  final String peerId;
  final String peerName;
  const ChatScreen({
    super.key,
    required this.peerId,
    required this.peerName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseService _firebaseService =
      FirebaseService();
  final TextEditingController msgController =
      TextEditingController();
  late final String chatRoomId;

  @override
  void initState() {
    super.initState();
    chatRoomId = getChatRoomId(
      user.uid,
      widget.peerId,
    ); // 👈 Initialize it in initState or use `late`
  }

  String getChatRoomId(String id1, String id2) {
    List<String> ids = [id1, id2];
    ids.sort();
    return ids.join('_'); // Always same for both users
  }

  void sendMessage() {
    if (msgController.text.trim().isNotEmpty) {
      final message = MessageModel(
        senderId: user.uid,
        message: msgController.text.trim(),
        timestamp: DateTime.now(),
      );
      _firebaseService.sendMessage(chatRoomId, message);
      msgController.clear();
    } else {
      Get.snackbar('message empty', 'enter a message');
    }
  }

  void _showEditDialog(MessageModel message) {
    final TextEditingController editController =
        TextEditingController(text: message.message);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Message'),
        content: TextField(
          controller: editController,
          decoration: InputDecoration(
            hintText: 'Enter new message',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (editController.text.trim().isNotEmpty &&
                  message.id != null) {
                _firebaseService.updateMessage(
                  chatRoomId,
                  message.id!,
                  editController.text.trim(),
                );
                Navigator.pop(context);
              }
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.peerName,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.call),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: _firebaseService.getMessages(
                chatRoomId,
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final messages = snapshot.data!;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final me =
                        messages[index].senderId ==
                        user.uid;
                    return Align(
                      alignment: me
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: GestureDetector(
                        onLongPress: me
                            ? () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text('Options'),
                                    content: Text(
                                      'What would you like to do?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                            context,
                                          ); // Close options
                                          _showEditDialog(
                                            messages[index],
                                          );
                                        },
                                        child: Text('Edit'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _firebaseService
                                              .deleteMessage(
                                                chatRoomId,
                                                messages[index]
                                                    .id!,
                                              );
                                          Navigator.pop(
                                            context,
                                          );
                                        },
                                        child: Text(
                                          'Delete',
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            : null,

                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: me
                                ? const Color.fromARGB(
                                    255,
                                    144,
                                    192,
                                    232,
                                  )
                                : const Color.fromARGB(
                                    255,
                                    198,
                                    218,
                                    180,
                                  ),
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          child: Text(
                            messages[index].message,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextField(
                    controller: msgController,
                    decoration: InputDecoration(
                      hintText: "Type a message",

                      enabledBorder: InputBorder.none,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: sendMessage,
                icon: Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
