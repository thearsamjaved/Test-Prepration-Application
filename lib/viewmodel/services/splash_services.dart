import 'dart:async';
import 'package:adil_fyp/Utality/routes/route_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    print(user.toString());
    if (user != null) {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, RouteNames.subjectscreen);
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, RouteNames.login);
      });
    }
  }
}
