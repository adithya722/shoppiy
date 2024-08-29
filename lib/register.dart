// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
   TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  child: Image.asset("assets/login.gif"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Text(
                        "Welcome to E-Shop",
                        style: TextStyle(
                          fontSize: 33,
                          color: Color.fromARGB(255, 51, 29, 3),
                          shadows: const [
                            Shadow(
                              blurRadius: 10.0,
                              color: Color.fromARGB(255, 133, 83, 23),
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 25,
                ),
                  TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: "Name",
                    icon: Icon(Icons.person),
                    iconColor: Color.fromARGB(255, 84, 35, 7),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "Email ID",
                    icon: Icon(Icons.email),
                    iconColor: Color.fromARGB(255, 84, 35, 7),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    icon: Icon(Icons.lock_open),
                    iconColor: Color.fromARGB(255, 84, 35, 7),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () async {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email.text.trim(),
                        password: password.text.trim(),
                      );
                      // Navigate to login screen upon successful registration
                      Navigator.pushReplacementNamed(context, Routes.login);

                      // Show success dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Success"),
                          content: Text("Registered successfully"),
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
                    } catch (e) {
                      // Handle registration errors
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
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 84, 35, 7),
                          Color.fromARGB(255, 155, 210, 191),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(3, 3),
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
