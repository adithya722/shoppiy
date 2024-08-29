// ignore_for_file: prefer_const_constructors

import 'package:firebase/login.dart';

import 'package:firebase/register.dart';
import 'package:firebase/routes.dart';
import 'package:firebase/screen.dart/account.dart';
import 'package:firebase/screen.dart/buy.dart';
import 'package:firebase/screen.dart/cart.dart';

import 'package:firebase/screen.dart/categories.dart';
import 'package:firebase/screen.dart/check.dart';

import 'package:firebase/screen.dart/favorite.dart';
import 'package:firebase/screen.dart/homepage2.dart';

import 'package:firebase/screen.dart/notification.dart';
import 'package:firebase/screen.dart/paym.dart';
import 'package:firebase/screen.dart/productscreen.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? Routes.login
          : Routes.home2,
      routes: {
        Routes.login: (context) => const Login(),
        Routes.register: (context) => const Register(),
        Routes.account: (context) => Account(),
        Routes.notification: (context) => const Notifications(),
        Routes.favorite: (context) => Favourite(),
        Routes.navigation: (context) => const Navigator(),
        Routes.categories: (context) => const Categories(),
        Routes.home2: (context) => const Homepage2(),
        Routes.cart: (context) => const Cart(),
        Routes.productscreen: (context) =>  ProductScreen(),
        Routes.buy: (context) =>  Buy(),
         Routes.paym: (context) => const Payment(),
         Routes.check: (context) =>const  Check(),
      },
    );
  }
}
