import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';

class FirebaseAuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuthService({FirebaseAuth firebaseAuth});

  static Future<String> signInWithGoogle() async {
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
