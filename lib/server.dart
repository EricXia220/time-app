import 'dart:async';
import 'dart:io';
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
    database.reference().child(user.uid + "/rank").set("Bronze IV");
    database.reference().child(user.uid + "/rankColor").set(1);
    database.reference().child(user.uid + "/rankBadge").set(1);
    database.reference().child(user.uid + "/streak").set(0);
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
      String title, String difficulty, String frequency, String time, int hour, int minute) async {
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
      "streak": 0,
      "lastCompletionTime": 0,
      "hour": hour,
      'minute': minute,
    });
  }

  Future<void> setLastCompletionTime(String id) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    await database
        .reference()
        .child(user.uid + "/" + "sm" + "/" + "sm-" + id + "/lastCompletionTime")
        .set(
      new DateTime.now().millisecondsSinceEpoch
    );
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
  Future<DataSnapshot> getAchievements() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    Future<DataSnapshot> ds =
    database.reference().child(user.uid + "/" + "achievements").once();

    return ds;
  }

  Future<void> addBigGoal(String title, String difficulty) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    await database.reference().child(user.uid + "/" + "bg" + "/bg1").set({
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

  Future<void> addStreak() async{
    FirebaseUser user = await _firebaseAuth.currentUser();
    DataSnapshot ds = await database
        .reference()
        .child(user.uid + "/" + "sm")
        .once();
    DataSnapshot ds2 =
    await database.reference().child(user.uid + "/" + "streak").once();
    var date = new DateTime.fromMillisecondsSinceEpoch(new DateTime.now().millisecondsSinceEpoch);
    bool add = true;
    var streak = ds2.value;
    print(ds);
    ds.value.forEach((k, v) {
      print(v);
      print(v['title']);
      var date2 = new DateTime.fromMillisecondsSinceEpoch(v['lastCompletionTime']);
      if (date2.day != date.day) {
        add = false;
        }
      print(date2.day);
      print(date.day);
    });
    if (add) {
      streak++;
      await database.reference().child(user.uid + "/streak").set(streak);
      }

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
    if (difficulty == "Easy") {
      points += 10;
    } else if (difficulty == "Medium") {
      points += 15;
    } else {
      points += 20;
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
    DataSnapshot ds3 = await database
        .reference()
        .child(user.uid + "/" + "bg" + "/" + "bg1" + "/" + "title")
        .once();
    var difficulty = ds.value;
    var points = 0;
    var id = new DateTime.now().millisecondsSinceEpoch.toString();
    if (ds2.value != null) {
      points = ds2.value;
    }
    if (difficulty == "Easy") {
      points += 150;
    } else if (difficulty == "Medium") {
      points += 200;
    } else if (difficulty == "Hard"){
      points += 250;
    }
    await database.reference().child(user.uid + "/achievements" + "/a" + id + "/title").set(ds3.value);
    await database.reference().child(user.uid + "/achievements" + "/a" + id + "/id").set(id);
    await database.reference().child(user.uid + "/points").set(points);
    await database.reference().child(user.uid + "/lastAchievement").set(ds3.value);
    await database
        .reference()
        .child(user.uid + "/" + "bg" + "/" + "bg1")
        .remove();
  }
  Future<void> setRank() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    DataSnapshot ds = await database.reference().child(user.uid + "/" + "points").once();
    var rank;
    var color;
    var badge;
    var point = ds.value;
    if (point >= 4500) {
      rank = "Master";
      color = 6;
      badge = 4;
      }
    else if (point >= 4000)
      {
        rank = "Diamond I";
        color = 5;
        badge = 4;
      }
    else if (point >= 3700)
    {
      rank = "Diamond II";
      color = 5;
      badge = 3;
    }
    else if (point >= 3400)
    {
      rank = "Diamond III";
      color = 5;
      badge = 2;
    }
    else if (point >= 3100)
    {
      rank = "Diamond IV";
      color = 5;
      badge = 1;
    }
    else if (point >= 2800)
    {
      rank = "Platinum I";
      color = 4;
      badge = 4;
    }
    else if (point >= 2550)
    {
      rank = "Platinum II";
      color = 4;
      badge = 3;
    }
    else if (point >= 2300)
    {
      rank = "Platinum III";
      color = 4;
      badge = 2;
    }
    else if (point >= 2050)
    {
      rank = "Platinum IV";
      color = 4;
      badge = 1;
    }
    else if (point >= 1800)
    {
      rank = "Gold I";
      color = 3;
      badge = 4;
    }
    else if (point >= 1600)
    {
      rank = "Gold II";
      color = 3;
      badge = 3;
    }
    else if (point >= 1400)
    {
      rank = "Gold III";
      color = 3;
      badge = 2;
    }
    else if (point >= 1200)
    {
      rank = "Gold IV";
      color = 3;
      badge = 1;
    }
    else if (point >= 950)
    {
      rank = "Silver I";
      color = 2;
      badge = 4;
    }
    else if (point >= 800)
    {
      rank = "Silver II";
      color = 2;
      badge = 3;
    }
    else if (point >= 650)
    {
      rank = "Silver III";
      color = 2;
      badge = 2;
    }
    else if (point >= 500)
    {
      rank = "Silver IV";
      color = 2;
      badge = 1;
    }
    else if (point >= 300)
    {
      rank = "Bronze I";
      color = 1;
      badge = 4;
    }
    else if (point >= 200)
    {
      rank = "Bronze II";
      color = 1;
      badge = 3;
    }
    else if (point >= 100)
    {
      rank = "Bronze III";
      color = 1;
      badge = 2;
    }
    else if (point >= 0)
    {
      rank = "Bronze IV";
      color = 1;
      badge = 1;
    }
    await database.reference().child(user.uid + "/rank").set(rank);
    await database.reference().child(user.uid + "/rankColor").set(color);
    await database.reference().child(user.uid + "/rankBadge").set(badge);
  }
  Future<dynamic> getRank() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    DataSnapshot ds = await database.reference()
        .child(user.uid + "/" + "rank")
        .once();
    return ds;
  }
  Future<dynamic> getName() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    DataSnapshot ds = await database.reference()
        .child(user.uid + "/" + "name")
        .once();
    return ds;
  }
  Future<dynamic> getStreak() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    DataSnapshot ds = await database.reference()
        .child(user.uid + "/" + "streak")
        .once();
    return ds;
  }
  Future<void> updateCompletion(String id) async{
    FirebaseUser user = await _firebaseAuth.currentUser();
    DataSnapshot ds = await database.reference()
        .child(user.uid + "/" + "sm" + "/" + id)
        .once();
    var lastTime = new DateTime.fromMillisecondsSinceEpoch(
        ds['lastCompletionTime']);

  }
  Future<void> updateStreak() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    DataSnapshot ds = await database.reference()
        .child(user.uid + "/" + "sm")
        .once();
    var reset = false;
    var date = new DateTime.fromMillisecondsSinceEpoch(new DateTime.now().millisecondsSinceEpoch);
    ds.value.forEach((k, v) {
      print(v);
      print(v['title']);
      var date2 = new DateTime.fromMillisecondsSinceEpoch(v['lastCompletionTime']);
      var id = v["id"];
      if (date.day - date2.day > 1) {
        database
            .reference()
            .child(user.uid + "/" + "sm" + "/" + "sm-" + id + "/" + "streak")
            .set(0);
        reset = true;
      }
      print(date2.day);
      print(date.day);
    });
    if (reset){
      database
          .reference()
          .child(user.uid + "/streak")
          .set(0);
    }
  }
}
