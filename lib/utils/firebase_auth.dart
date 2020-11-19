import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<String> signInWithGoogle() async {
    try {
      final userCredentials =
          await _firebaseAuth.signInWithPopup(GoogleAuthProvider());
      var jwt = await userCredentials.user.getIdToken();
      return jwt;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
