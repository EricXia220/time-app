import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Server {
  var smallNum = 1;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase database = new FirebaseDatabase();

  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<String> signUpWithProfile(
    String email,
    String password,
    String name,
  ) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    database.reference().child(user.uid + "/name").set(name);
    database.reference().child(user.uid + "/points").set(0);
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

  Future<dynamic> getUsers() async {
    Future<DataSnapshot> ds = database.reference().child("/").once();
    return ds;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> addSmallGoal(
      String title, String difficulty, String frequency, String time) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    var id = new DateTime.now().millisecondsSinceEpoch.toString();
    await database
        .reference()
        .child(user.uid + "/" + "sm" + "/" + "sm-" + id)
        .set({
      "title": title,
      "difficulty": difficulty,
      "frequency": frequency,
      "time": time,
      "id": id,
      "streak": 0
    });
  }

  Future<void> deleteSmallGoal(String id) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    await database
        .reference()
        .child(user.uid + "/" + "sm" + "/" + "sm-" + id)
        .remove();
  }

  Future<DataSnapshot> getSmallGoals() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    Future<DataSnapshot> ds =
        database.reference().child(user.uid + "/" + "sm").once();
    return ds;
  }

  Future<void> addBigGoal(String title, String difficulty) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    await database.reference().child(user.uid + "/" + "bg" + "/" + "bg1").set({
      "title": title,
      "difficulty": difficulty,
    });
  }

  Future<DataSnapshot> getBigGoals() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    Future<DataSnapshot> ds =
        database.reference().child(user.uid + "/" + "bg").once();
    return ds;
  }

  Future<void> completeSm(String id) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    DataSnapshot ds = await database
        .reference()
        .child(user.uid + "/" + "sm" + "/" + "sm-" + id + "/" + "streak")
        .once();
    DataSnapshot ds2 =
        await database.reference().child(user.uid + "/" + "points").once();
    DataSnapshot ds3 = await database
        .reference()
        .child(user.uid + "/" + "sm" + "/" + "sm-" + id + "/" + "difficulty")
        .once();
    var streak = ds.value + 1;
    var difficulty = ds3.value;
    var points = 0;
    if (ds2.value != null) {
      points = ds2.value;
    }
    if (difficulty == "easy") {
      points += 1;
    } else if (difficulty == "medium") {
      points += 2;
    } else {
      points += 3;
    }

    await database.reference().child(user.uid + "/points").set(points);
    await database
        .reference()
        .child(user.uid + "/" + "sm" + "/" + "sm-" + id + "/" + "streak")
        .set(streak);
  }

  Future<void> completeBg() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    DataSnapshot ds = await database
        .reference()
        .child(user.uid + "/" + "bg" + "/" + "bg1" + "/" + "difficulty")
        .once();
    DataSnapshot ds2 =
        await database.reference().child(user.uid + "/" + "points").once();
    var difficulty = ds.value;
    var points = 0;
    if (ds2.value != null) {
      points = ds2.value;
    }
    if (difficulty == "easy") {
      points += 10;
    } else if (difficulty == "medium") {
      points += 20;
    } else if (difficulty == "hard"){
      points += 30;
    }

    await database.reference().child(user.uid + "/points").set(points);
    await database
        .reference()
        .child(user.uid + "/" + "bg" + "/" + "bg1")
        .remove();
  }
}
