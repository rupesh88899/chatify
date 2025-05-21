import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/signup_page.dart';

import 'package:chat_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatelessWidget {
  final UserServices _userServices = UserServices();
  final String currentUserId =
      FirebaseAuth.instance.currentUser!.uid;
  UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final curUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        211,
        203,
        221,
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(
                255,
                194,
                206,
                255,
              ),
              radius: 45,
              backgroundImage: curUser?.photoURL != null
                  ? NetworkImage(curUser!.photoURL!)
                  : null,
              child: curUser?.photoURL == null
                  ? Text(
                      curUser?.email
                              ?.substring(0, 1)
                              .toUpperCase() ??
                          '?',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    )
                  : null,
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(
          193,
          156,
          138,
          190,
        ),
        title: Text(
          'Friends!',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(
          255,
          152,
          130,
          176,
        ),
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => SignupScreen(),
            ),
            (Route<dynamic> route) => false,
          );
        },
        child: const Icon(
          Icons.logout,
          size: 30,
          color: Color.fromARGB(255, 184, 47, 38),
        ),
      ),

      body: FutureBuilder<List<AppUser>>(
        future: _userServices.fetchAllUsers(currentUserId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final users = snapshot.data!;
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Text(users[index].name[0]),
                ),
                title: Text(
                  users[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        peerId: users[index].uid,
                        peerName: users[index].name,
                      ),
                    ),
                  );
                },
              );
            },
            itemCount: users.length,
          );
        },
      ),
    );
  }
}
