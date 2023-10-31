import 'package:adil_fyp/model/user_model.dart';
import 'package:adil_fyp/repository/auth_repo.dart';
import 'package:adil_fyp/repository/user_repository.dart';
import 'package:flutter/material.dart';

class AuthViewModel with ChangeNotifier {
  final AuthRepository _myrepo = AuthRepository();
  final UserRepository _userrepo = UserRepository();
  bool _obsecureText = true;
  bool _isloading = false;
  String _chosenvalue = '';
  bool get obsecureText => _obsecureText;
  bool get isloading => _isloading;
  String get chosenvalue => _chosenvalue;

  setObsecure(bool val) {
    _obsecureText = val;
    notifyListeners();
  }

  setLoading(var val) {
    _isloading = val;
    notifyListeners();
  }

  setChosenValue(val) {
    _chosenvalue = val;
    notifyListeners();
  }

  void signupUser(
      UserModel user, var email, var passwordm, BuildContext context) {
    setLoading(true);
    _myrepo.createUser(email, passwordm, context, user);

    setLoading(false);
  }

  void signinUser(var email, var password, BuildContext context) {
    setLoading(true);
    _myrepo.signinUser(email, password, context);
    setLoading(false);
  }
}
