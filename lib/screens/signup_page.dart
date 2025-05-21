import 'package:chat_app/auth/auth.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final Auth authService = Auth(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
  Future<void> signUp(BuildContext context) async {
    final user = await authService.emailPasswordSignUp(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
      phone: phoneController.text,
      context: context,
    );
    if (user != null) {
      Get.snackbar('Signup Successful', 'Please LogIn ');
      Get.offAll(() => SignInScreen());
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
              SizedBox(height: 130),

              Text(
                'SignUp...',
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
              SizedBox(height: 48),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 6,
                ),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  controller: nameController,

                  decoration: InputDecoration(
                    hintText: 'Enter name',

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
                  controller: phoneController,

                  decoration: InputDecoration(
                    hintText: 'Enter phone number',

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
                        width: 3,
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

              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      signUp(context);
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
                      'SignUp !',
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
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: const Color.fromARGB(
                          255,
                          15,
                          15,
                          15,
                        ),
                        fontSize: 16,
                      ),
                    ),

                    WidgetSpan(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignInScreen();
                              },
                            ),
                          );
                        },

                        // ignore: sort_child_properties_last
                        child: Text(
                          'LogIn.',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
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
