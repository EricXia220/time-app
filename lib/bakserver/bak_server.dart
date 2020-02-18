import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


class ServerBak {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  DatabaseReference _userRef;
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

  /**
   * This is a sample of the usage.
   *
   *  server.createMeeting("yu tm", "Wed 5pm", "Social", "ARC").then((meetingId){
      print("The meeting is created: " + meetingId);
      }).catchError((e){
      print("Failed to create the meeting. " + e.toString());
      });
   */
  Future<String> createMeeting(String name, String datetime, String theme,
      String location) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    // create a meeting under meetings
    // generate a unique meeting Id
    String meetingId = (new DateTime.now().millisecondsSinceEpoch / 1000)
        .toInt()
        .toString();
    database.reference().child("/meetings/" + meetingId + "/name").set(name);
    database.reference().child("/meetings/" + meetingId + "/datetime").set(
        datetime);
    database.reference().child("/meetings/" + meetingId + "/theme").set(theme);
    database.reference().child("/meetings/" + meetingId + "/location").set(
        location);

    // add the meeting to the user profile
    database.reference().child("/users/" + user.uid + "/myhostmeetings")
        .push()
        .set(meetingId);

    return meetingId;
  }

  Future<String> voteAward(String meetingId, String awardId, String uid) {
    database.reference()
        .child("/meetings/" + meetingId + "/voting/" + awardId)
        .push()
        .set(uid);
  }

  Future<List<String>> listMyHostedMeetings() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    // create a meeting under meetings
    // generate a unique meeting Id

    List<String> meetingIds = new List();
    // add the meeting to the user profile
    await database.reference()
        .child("/users/" + user.uid + "/myhostmeetings")
        .once()
        .then((ds) {
      print("receiving data: ");
      print(ds.key);
      print(ds.value);
      ds.value.forEach((k, v) {
        print(v);
        meetingIds.add(v);
      });
    });

    return meetingIds;
  }

  Future<Map> getUserProfile(String uid) async {
    Map userProfile = null;
    await database.reference().child("/users/" + uid).once().then((ds) {
      print(ds.key);
      print(ds.value);
      print(ds.value['name']);
      print(ds.value['level']);
      print("Returning DS: " + ds.value.toString());
      userProfile = ds.value;
    }).catchError((e) {
      print("Failed to get the users.");
    });
    return userProfile;
  }

  submitEvaluation(String meetingId, String uid, String comments,
      String preparedScore, String tableScore, String evaluatorScore) {
    // FirebaseUser user = await _firebaseAuth.currentUser();
    database.reference().child(
        "/meetings/" + meetingId + "/evaluations/" + uid + "/comments/").set(
        comments);
    database.reference()
        .child(
        "/meetings/" + meetingId + "/evaluations/" + uid + "/preparedScore/")
        .set(preparedScore);
    database.reference().child(
        "/meetings/" + meetingId + "/evaluations/" + uid + "/tableScore/").set(
        tableScore);
    database.reference()
        .child(
        "/meetings/" + meetingId + "/evaluations/" + uid + "/evaluatorScore/")
        .set(evaluatorScore);
    // database.reference().child("/meetings/" + meetingId + "/evaluations/" + user.uid + "/name/").set(name);
    // database.reference().child("/meetings/" + meetingId + "/evaluations/" + user.uid + "/comments/").set(comments);
    // database.reference().child("/meetings/" + meetingId + "/evaluations/" + user.uid + "/scores/preparedScore/").set(preparedScore);
    // database.reference().child("/meetings/" + meetingId + "/evaluations/" + user.uid + "/scores/tableScore/").set(tableScore);
    // database.reference().child("/meetings/" + meetingId + "/evaluations/" + user.uid + "/scores/evaluatorScore/").set(evaluatorScore);
    print("writing evaluations to db");
  }

  Future getUserEvaluation(String meetingId) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    // Map userEvaluation = new Map();
    DataSnapshot ds = await database.reference().child(
        "/meetings/" + meetingId + "/evaluations/" + user.uid).once();
    print('getting user eval: ' + ds.value.toString());
    return ds.value;
  }

  Future<int> getUserVote(String meetingId, String awardId, String uid) async {
    DataSnapshot ds = await database.reference().child(
        "/meetings/" + meetingId + "/awards/" + awardId + "/" + uid).once();
    return ds.value;
  }

  Future<List<String>> listMeetingParticipantIds(String meetingId) async {
    List<String> pIds = new List();
    await database.reference()
        .child("/meetings/" + meetingId + "/participants")
        .once()
        .then((ds) {
      print("receiving data: ");
      print(ds.key);
      print(ds.value);
      ds.value.forEach((k, v) {
        print(k);
        pIds.add(k);
      });
    });
    return pIds;
  }

  Future<Map> getMeetingDetails(String meetingId) async {
    Map details = new Map();
    DataSnapshot ds = await database.reference()
        .child("/meetings/" + meetingId)
        .once();
    details = ds.value;
    print("getting meeting details: " + details.toString());
    return details;
  }

  Future<List<Map>> listParticipantVotes(String meetingId,
      String awardId) async {
    List<String> pIds = await listMeetingParticipantIds(meetingId);
    List<Map> participants = new List();
    print("getting ids: " + pIds.toString());
    for (String id in pIds) {
      int votes = await getUserVote(meetingId, awardId, id);
      Map profile = await getUserProfile(id);
      profile[awardId] = votes;
      profile['uid'] = id;
      participants.add(profile);
      print("added a profile");
    }
    print("returning the participant votes");
    return participants;
  }

  Future<List<Map>> listParticipantProfile(String meetingId) async {
    List<String> pIds = await listMeetingParticipantIds(meetingId);
    List<Map> participants = new List();
    for (String id in pIds) {
      Map profile = await getUserProfile(id);
      profile['uid'] = id;
      participants.add(profile);
    }
    return participants;
  }

  Future<Map> getMaxVotes(String meetingId, String awardId) async {
    List<String> pIds = await listMeetingParticipantIds(meetingId);
    List<Map> participants = new List();
    print("getting ids: " + pIds.toString());
    int max = -1;
    Map maxProfile;
    for (String id in pIds) {
      int votes = await getUserVote(meetingId, awardId, id);
      if (votes == null) {
        votes = 0;
      }
      Map profile = await getUserProfile(id);
      profile[awardId] = votes;
      profile['uid'] = id;
      participants.add(profile);
      print("added a profile");
      if (votes > max) {
        max = votes;
        maxProfile = profile;
      }
    }
    print("returning the participant votes");
    return maxProfile;
  }

  listenToFirebase(String meetingId) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    database
        .reference()
        .child("/meetings/" + meetingId + "/participants/" + user.uid)
        .onValue
        .listen((snapshot) {
      print("vote snapshots: " + snapshot.snapshot.value.toString());
      onVoteUpdated(user.uid, meetingId);
    });
  }

  onVoteUpdated(String uid, String meetingId) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    var _votes;
    database
        .reference()
        .child("/meetings/" + meetingId + "/participants/" + user.uid)
        .onChildChanged
        .listen((event) {
      _votes = event.snapshot.value;
    });
    return _votes;
  }


  increaseVote(String meetingId, String awardId, String uid) async {
    var _voteCount = 0;
    DataSnapshot ds = await database.reference().child(
        "/meetings/" + meetingId + "/awards/" + awardId + "/" + uid).once();
    if (ds.value != null) {
      _voteCount = ds.value;
    }
    _voteCount = _voteCount + 1;
    database.reference().child(
        "/meetings/" + meetingId + "/awards/" + awardId + "/" + uid).set(
        _voteCount);
    print('increase vote count: ' + _voteCount.toString());
    return _voteCount;
  }

  /*
    server.listMeetingParticipants("1563822660").then((participants){
      print("Meeting participants: " + participants.toString());
    }).catchError((e){
    });
   */
  Future<List<Map>> listMeetingParticipants(String meetingId) async {
    List<String> pIds = await listMeetingParticipantIds(meetingId);
    List<Map> participants = new List();
    print("getting ids: " + pIds.toString());
    for (String id in pIds) {
      Map userProfile = await getUserProfile(id);
      print(userProfile);
      participants.add(userProfile);
      print("added a profile");
    }
    print("returning the participants");
    return participants;
  }


  Future<List<String>> listMyJoinedMeetings() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    // create a meeting under meetings
    // generate a unique meeting Id

    Set<String> meetingIds = new Set();
    // add the meeting to the user profile
    await database.reference()
        .child("/users/" + user.uid + "/myjoinedmeetings")
        .once()
        .then((ds) {
      print("receiving data: ");
      print(ds.key);
      print(ds.value);
      ds.value.forEach((k, v) {
        print(v);
        meetingIds.add(v);
      });
    });

    return meetingIds.toList();
  }

  /**
   * This is a sample of the usage.
   *
   *  server.joinMeeting("1569489343").then((meetingId){
      print("The meeting is created: " + meetingId);
      }).catchError((e){
      print("Failed to create the meeting. " + e.toString());
      });
   */

  Future<String> joinMeeting(String meetingId) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    String result = 'false';
    await database.reference().child("/meetings").once().then((ds) {
      ds.value.forEach((k,v) {
        if(k == meetingId) {
          database.reference().child("/users/" + user.uid + "/myjoinedmeetings").push().set(meetingId);
          // database.reference().child("/meetings/" + meetingId + "/participants/" + user.uid).set("OK");
          database.reference().child("/meetings/" + meetingId + "/participants/" + user.uid).set(0);
          result = meetingId;
        }
      });
    });

    return result;
  }

  Future<String> updateMeeting(String meetingId, String name, String datetime,
      String theme, String location) async {
    database.reference().child("meetings/" + meetingId + "/name").set(name);
    database.reference().child("meetings/" + meetingId + "/datetime").set(
        datetime);
    database.reference().child("meetings/" + meetingId + "/theme").set(theme);
    database.reference().child("meetings/" + meetingId + "/location").set(
        location);
    return 'successfully updated $meetingId';
  }

  Future<String> resetVotes(String meetingId) async {
    database.reference().child("/meetings/" + meetingId + "/awards").remove();
    return 'successfully removed votes in $meetingId';
  }

  removeParticipant(String meetingId, String name) async {
    List<String> pIds = await listMeetingParticipantIds(meetingId);
    for (String id in pIds) {
      Map userProfile = await getUserProfile(id);
      if (userProfile['name'] == name) {
        database.reference().child(
            "/meetings/" + meetingId + "/participants/" + id).remove();
        print('remove userProfile: ' + userProfile.toString());
      }
    }
  }

  Future<String> signUp(String email, String password) async {
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