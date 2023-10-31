import 'package:adil_fyp/Utality/utils.dart';
import 'package:adil_fyp/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;
  void createUserdetails(UserModel user) async {
    await _db
        .collection('User')
        .doc(user.email)
        .set(user.toJson())
        .then((value) {
      return Utils.toastMessage('Successful');
    }).onError((error, stackTrace) {
      return Utils.toastMessage(error.toString());
    });
  }
}
