
import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  Future<UserCredential> signIn(
      String email, String password,) async {
    UserCredential result;
    String errorMessage;

    try {
      result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((onError) {
        
        return null;
      });
    } catch (error) {
      return null;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return result;
  }
}