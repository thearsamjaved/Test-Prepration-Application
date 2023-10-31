import 'package:adil_fyp/Utality/routes/route_name.dart';
import 'package:adil_fyp/Utality/utils.dart';
import 'package:adil_fyp/model/user_model.dart';
import 'package:adil_fyp/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserRepository _userrepo = UserRepository();
  void createUser(
      var email, var password, BuildContext context, UserModel user) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        _userrepo.createUserdetails(user);
        return Navigator.pushReplacementNamed(
            context, RouteNames.subjectscreen);
      });
    } on FirebaseAuthException catch (error) {
      Utils.toastMessage(error.message.toString());
    }
  }

  void signinUser(var email, var password, BuildContext context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user != null) {
          Utils.toastMessage('Success');
          return Navigator.pushReplacementNamed(
              context, RouteNames.subjectscreen);
        }
      });
    } on FirebaseAuthException catch (e) {
      return Utils.toastMessage(e.message.toString());
    }
  }
}
