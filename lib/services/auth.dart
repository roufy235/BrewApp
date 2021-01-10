import 'package:brew_app/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return this._auth.onAuthStateChanged
        .map((FirebaseUser user) => this._userFromFirebaseUser(user));
  }

  Future signInAnon() async {
    try {
      AuthResult result = await this._auth.signInAnonymously();
      FirebaseUser user = result.user;
      return this._userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}