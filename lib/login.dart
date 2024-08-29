// ignore_for_file: prefer_const_constructors, unused_local_variable, use_build_context_synchronously, dead_code
import 'package:firebase/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
    // TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 17)),
                Container(
                  child: Image.asset("assets/login.gif"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 17),
                  child: Row(
                    children: [
                      Text(
                        "Sign in to your account",
                        style: TextStyle(
                          fontSize: 23,
                          color: Color.fromARGB(255, 51, 29, 3),
                          shadows: const [
                            Shadow(
                              blurRadius: 10.0,
                              color: Color.fromARGB(255, 133, 83, 23),
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              //      SizedBox(height: 35),
              //   TextFormField(
              //   controller: name,
              //   decoration: InputDecoration(
              //     labelText: "NAME",
              //     icon: Icon(Icons.person),
              //     iconColor: Color.fromARGB(255, 64, 34, 4),
              //     labelStyle: TextStyle(
              //       color: Colors.grey,
              //     ),
              //     border: OutlineInputBorder(),
              //     focusedBorder: OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter some text';
              //     }
              //     return null;
              //   },
              // ),
                SizedBox(height: 25),
                TextFormField(
                controller: email,
                decoration: InputDecoration(
                  labelText: "Email ID",
                  icon: Icon(Icons.email),
                  iconColor: Color.fromARGB(255, 64, 34, 4),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
                SizedBox(height: 25),
                 TextFormField(
                obscureText: true,
                controller: password,
                decoration: InputDecoration(
                  labelText: "Password ",
                  icon: Icon(Icons.lock_open),
                  iconColor: Color.fromARGB(255, 64, 39, 4),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter some text";
                  } else if (!RegExp(
                          "^(?=.{8,32}\$)(?=.*[a-z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*")
                      .hasMatch(value)) {
                    return 'not a valid password';
                  }
                  return null;
                },
              ),
                SizedBox(height: 25),
                MaterialButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email.text.trim(),
                        password: password.text.trim(),
                      );
                      // Navigate to home screen upon successful login
                      Navigator.of(context).pushReplacementNamed(Routes.home2);

                      // Show success dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Success"),
                          content: Text("Logged in successfully"),
                          // actions: [
                          //   TextButton(
                          //     onPressed: () {
                          //       Navigator.of(context).pop();
                          //     },
                          //     child: Text('OK'),
                          //   ),
                          // ],
                        ),
                      );
                    } catch (e) {
                      // Handle login errors
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: 82,
                    height: 34,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 84, 35, 7),
                          Color.fromARGB(255, 155, 210, 191),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 7,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member? ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 64, 42, 3),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.register);
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color.fromARGB(255, 46, 31, 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
