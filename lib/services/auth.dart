import 'package:brew_app/models/User.dart';
import 'package:brew_app/services/DatabaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return this
        ._auth
        .onAuthStateChanged
        .map((FirebaseUser user) => this._userFromFirebaseUser(user));
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await this._auth
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid)
          .updateUserData('sugars', 100, 'name');
      return this._userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await this._auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return this._userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future signInAnon() async {
    try {
      AuthResult result = await this._auth.signInAnonymously();
      FirebaseUser user = result.user;
      return this._userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await this._auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
