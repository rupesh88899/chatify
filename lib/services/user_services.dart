
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserServices {
  final _firestore = FirebaseFirestore.instance;
  Future<List<AppUser>> fetchAllUsers(String currentUserId) async {
    final snapshot = await _firestore.collection('users').get();
    return snapshot.docs
        .where((doc) => doc.id != currentUserId)
        .map((doc) => AppUser.fromMap(doc.data()))
        .toList();
  }
}
