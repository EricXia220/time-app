import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Server {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase database = new FirebaseDatabase();

  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<String> signUpWithProfile(String email, String password, String name,
      String level) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    database.reference().child("/users/" + user.uid + "/name").set(name);
    database.reference().child("/users/" + user.uid + "/level").set(level);
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    print("called " + email);
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}