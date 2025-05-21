
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Auth {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  Auth({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  }) : _auth = auth,
       _firestore = firestore;

  CollectionReference get _users => _firestore.collection('users');

  Future<AppUser?> emailPasswordSignUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required BuildContext context,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = AppUser(
        uid: cred.user!.uid,
        name: name,
        email: email,
        phone: phone,
        avatarUrl: '',
      );
      await _users.doc(user.uid).set(user.toMap());
       // ignore: avoid_print
       print('User saved to Firestore: ${user.uid}');
      return user;
    } on FirebaseException catch (e) {
      Get.snackbar('error', '{$e}'.toString().trim());
    }
    return null;
  }

  Future<AppUser?> emailPasswordSignIn({
    required String email,
    required String password,

    required BuildContext context,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final doc = await _users.doc(cred.user!.uid).get();
      if (doc.exists) {
        return AppUser.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        Get.snackbar('Error ', 'Data not found!');
        return null;
      }
    } on FirebaseException catch (e) {
      Get.snackbar(
        'Login Failed',
        e.message ?? 'Unknown error',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  void signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
