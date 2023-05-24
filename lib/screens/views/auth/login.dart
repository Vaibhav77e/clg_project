import 'dart:convert';

import 'package:clg_project/screens/views/auth/student.dart';
import 'package:clg_project/screens/views/auth/teacher.dart';
import 'package:clg_project/widgets/customPasswordField.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../widgets/button.dart';
import 'package:flutter_svg/svg.dart';
import '../../../widgets/customTextForm.dart';
import 'register.dart';
import 'package:http/http.dart' as http;

import '../../../models/users.dart';

class LoginPage extends StatefulWidget {
  // String role;
  // LoginPage({required this.role});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usnController = TextEditingController();
  final String assetName = 'assets/YIt_2.svg';
  final String USN = '';
  List<Users> _userList = [];

  List<Users> get userList {
    return [..._userList];
  }

  // Users newUser = Users(email: '', usn: '', password: '');

  int index = 0;

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: SvgPicture.asset(
                              assetName,
                              semanticsLabel: 'Clg logo',
                              width: 120,
                              height: 120,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          CustomTextField(
                            controller: emailController,
                            text: 'Email',
                            validator: (value) {
                              if (value!.length == 0) {
                                return "Email cannot be empty";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please enter a valid email");
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              emailController.text = value!;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          //usn/employee
                          CustomTextField(
                            controller: usnController,
                            text: 'USN/Empolyee id',
                            validator: (value) {
                              if (value!.length == 0) {
                                return "Field can't be left empty";
                              }
                            },
                            keyboardType: null,
                            onSaved: (value) {
                              usnController.text = value!;
                            },
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          CustomPasswordField(
                            controller: passwordController,
                            text: 'Password',
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              if (!regex.hasMatch(value)) {
                                return ("please enter valid password min. 6 character");
                              } else {
                                return null;
                              }
                            },
                            obscureText: _isObscure3,
                            onSaved: (value) {
                              passwordController.text = value!;
                            },
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          // Sign -in button
                          MyButton(
                            onTap: () {
                              setState(() {
                                visible = true;
                              });
                              // signIn(emailController.text,
                              //     passwordController.text);
                              // cutomlogin(usnController.text);
                              newsignIn(emailController.text,
                                  passwordController.text, usnController.text);
                            },
                            text: 'Sign In',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Sign-up button
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Register(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Sign Up for Free",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 16),
                                    )),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              visible: visible,
                              child: Container(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              ))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rool') == "Teacher") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Teacher(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Student(
                text: usnController.text,
              ),
            ),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void newroute(String usn, String email, String password) async {
    const uri =
        'https://clg-project-9ffdf-default-rtdb.asia-southeast1.firebasedatabase.app/usersData.json';
    try {
      final res = await http.get(Uri.parse(uri));
      final extratedData = json.decode(res.body) as Map<String, dynamic>;
      print('val1:$extratedData');
      if (extratedData == null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Student(
              text: usn,
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Teacher(),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // testing
  void newsignIn(String email, String password, String usn) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        newroute(usn, email, password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}

Future<void> cutomlogin(String token) async {
  try {
    final userCred = FirebaseAuth.instance.signInWithCustomToken(token);
    print("success");
  } on FirebaseAuthException catch (e) {
    print(e.toString());
  }
}
