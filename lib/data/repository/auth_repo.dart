import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  Future<String> getUserId() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) return currentUser.uid;

    final userCred = await FirebaseAuth.instance.signInAnonymously();
    return userCred.user!.uid;
  }
}
