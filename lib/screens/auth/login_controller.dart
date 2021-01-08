
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pagos_internet/shared/user_preferences.dart';

 Future<UserCredential> signIn(
      String email, String password,) async {
    UserCredential user;
    String errorMessage;

    try {
      user = await FirebaseAuth.instance
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
    return user;
  }



  void saveUserInStorate(UserCredential user){
    UserPrefrences prefrences = new UserPrefrences();
    prefrences.email = user.user.email;
    prefrences.username = user.user.displayName;
  } 