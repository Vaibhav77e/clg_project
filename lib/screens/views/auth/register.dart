import 'dart:convert';
import 'dart:io';
import 'package:clg_project/widgets/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../widgets/customPasswordField.dart';
import '../../../widgets/customTextForm.dart';
import 'login.dart';
import '../../../widgets/alert.dart';
import 'package:http/http.dart' as http;

// import 'model.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  _RegisterState();

  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController usnController = TextEditingController();
  final bool _isObscure = true;
  final bool _isObscure2 = true;
  final String assetName = 'assets/YIt_2.svg';

  File? file;
  var options = [
    'Student',
    'Teacher',
  ];
  var _currentItemSelected = "Student";
  var rool = "Student";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white54,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              // color: Colors.orangeAccent[700],
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 60,
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
                          height: 10,
                        ),

                        // custom button
                        CustomTextField(
                          controller: name,
                          text: 'Name',
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Name cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {},
                        ),
                        const SizedBox(
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
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {},
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

                        SizedBox(
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
                          obscureText: _isObscure,
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        CustomPasswordField(
                          controller: confirmpassController,
                          text: 'Confirm Password',
                          validator: (value) {
                            if (confirmpassController.text !=
                                passwordController.text) {
                              return "Password did not match";
                            } else {
                              return null;
                            }
                          },
                          obscureText: _isObscure2,
                          onSaved: (value) {},
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Role : ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                            DropdownButton<String>(
                              dropdownColor: Colors.white,
                              isDense: true,
                              isExpanded: false,
                              iconEnabledColor: Colors.purple,
                              focusColor: Colors.purple,
                              items: options.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style: const TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValueSelected) {
                                setState(() {
                                  _currentItemSelected = newValueSelected!;
                                  rool = newValueSelected;
                                });
                              },
                              value: _currentItemSelected,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Row(
                          children: [
                            const Text(
                              'Already have an Account ! ! !',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            TextButton(
                                onPressed: () {
                                  CircularProgressIndicator();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 16),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyButton(
                            onTap: () {
                              setState(() {
                                showProgress = true;
                              });
                              signUp(emailController.text,
                                  passwordController.text, rool);
                            },
                            text: 'Register'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void signUp(String email, String password, String rool) async {
  //   CircularProgressIndicator();
  //   try {
  //     if (_formkey.currentState!.validate()) {
  //       await _auth
  //           .createUserWithEmailAndPassword(email: email, password: password)
  //           .then((value) => {postDetailsToFirestore(email)})
  //           .catchError((e) {
  //         print(e.toString());
  //       });
  //     }
  //   } catch (e) {
  //     showDialog(
  //         context: context,
  //         builder: (builderctx) => Alert(
  //               text: e.toString(),
  //             ));
  //     Navigator.of(context).pop();
  //   }
  // }

  void signUp(String email, String password, String rool) async {
    CircularProgressIndicator();
    try {
      if (_formkey.currentState!.validate()) {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postToFirebasedara(email)})
            .catchError((e) {
          print(e.toString());
        });
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (builderctx) => Alert(
                text: e.toString(),
              ));
      Navigator.of(context).pop();
    }
  }

//   postDetailsToFirestore(String email, String rool) async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     var user = _auth.currentUser;
//     CollectionReference ref = firebaseFirestore.collection('users');
//     ref.doc(user!.uid).set({
//       'name': name.text,
//       'email': emailController.text,
//       'role': rool,
//     });
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => LoginPage()));
//   }
// }

  postDetailsToFirestore(
    String email,
  ) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = firebaseFirestore.collection('users');
    ref.doc(user!.uid).set({
      //'name': name.text,
      'email': emailController.text,
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  postToFirebasedara(
    String email,
  ) async {
    const url =
        'https://clg-project-9ffdf-default-rtdb.asia-southeast1.firebasedatabase.app/usersData.json';
    try {
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'name': name.text,
            'USN': usnController.text,
            'email': emailController.text
          }));

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      print(e.toString());
    }
  }
}
