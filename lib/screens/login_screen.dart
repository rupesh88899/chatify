import 'package:chat_app/auth/auth.dart';
import 'package:chat_app/screens/signup_page.dart';
import 'package:chat_app/screens/users_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();
  final Auth authService = Auth(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );

  Future<void> login(BuildContext context) async {
    final user = await authService.emailPasswordSignIn(
      email: emailController.text.trim(),
      password: passwordController.text,
      context: context,
    );
    if (user != null) {
      Get.offAll(() => UserListScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 180),

              Text(
                'LogIn... ',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(
                    51,
                    27,
                    88,
                    1,
                  ),
                ),
              ),
              SizedBox(height: 28),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 6,
                ),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  controller: emailController,

                  decoration: InputDecoration(
                    hintText: 'Enter email',

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      borderSide: BorderSide(
                        color: const Color.fromRGBO(
                          129,
                          127,
                          127,
                          1,
                        ),
                        width: 2,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(
                          255,
                          79,
                          77,
                          77,
                        ),
                        width: 2,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 6,
                ),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter password',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      borderSide: BorderSide(
                        color: const Color.fromRGBO(
                          129,
                          127,
                          127,
                          1,
                        ),
                        width: 2,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(
                          255,
                          79,
                          77,
                          77,
                        ),
                        width: 2,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      login(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                        255,
                        152,
                        130,
                        176,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                    ),
                    child: Text(
                      'LogIn !',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(
                        color: const Color.fromARGB(
                          255,
                          18,
                          18,
                          18,
                        ),
                        fontSize: 18,
                      ),
                    ),
                    WidgetSpan(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignupScreen();
                              },
                            ),
                          );
                        },
                        // ignore: sort_child_properties_last
                        child: Text(
                          'SignUp',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            textBaseline:
                                TextBaseline.ideographic,
                            decoration:
                                TextDecoration.underline,
                          ),
                        ),
                      ),

                      alignment:
                          PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
