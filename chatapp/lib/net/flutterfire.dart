import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

//_userFromFirebaseUser(User? user) {
//return user != null ? user.uid : null;
//}

Future<bool> login(String email, String password) async {
  try {
    //   UserCredential result =
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
    //   User? firebaseuser = result.user;
    // return _userFromFirebaseUser(firebaseuser);
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> registerUser(String email, String password) async {
  try {
    //UserCredential result =
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
    //User? firebaseuser = result.user;
    //return _userFromFirebaseUser(firebaseuser);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print("The password provided is weak");
      return false;
    } else if (e.code == 'email-already-in-use') {
      print("Email is already in use");
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future signOut() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await FirebaseAuth.instance.signOut();
    prefs.clear();
  } catch (e) {}
}
