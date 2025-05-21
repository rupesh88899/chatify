
import 'package:chat_app/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final _firestore = FirebaseFirestore.instance;
  Future<void> sendMessage(String chatRoomId, MessageModel message) async {
    await _firestore
        .collection("chats")
        .doc(chatRoomId)
        .collection("messages")
        .add(message.toMap());
  }

  Stream<List<MessageModel>> getMessages(String chatRoomId) {
    return _firestore
        .collection("chats")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp",)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => MessageModel.fromMap(doc.data(),doc.id))
                  .toList(),
        );
  }
  Future<void> updateMessage(String chatRoomId, String messageId, String newText) async {
    await _firestore
        .collection("chats")
        .doc(chatRoomId)
        .collection("messages")
        .doc(messageId)
        .update({'message': newText});
  }

    Future<void> deleteMessage(String chatRoomId, String messageId) async {
      await _firestore
          .collection("chats")
          .doc(chatRoomId)
          .collection('messages')
          .doc(messageId)
          .delete();
    }
  }

