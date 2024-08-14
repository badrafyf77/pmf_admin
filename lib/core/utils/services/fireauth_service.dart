import 'package:firebase_auth/firebase_auth.dart';

class FireauthService {
  final credential = FirebaseAuth.instance;

  Future<void> signIn(String email, String password) async {
      await credential.signInWithEmailAndPassword(
          email: email, password: password);
  }

}
