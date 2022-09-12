import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//recieves all the necessary info of a student and adds to the student collection in firebase
class AddRequest {
  final _auth = FirebaseAuth.instance;

  late final String date;
  late final String time;
  late final String pickup;
  late final String type;

  AddRequest(
    this.date,
    this.time,
    this.pickup,
    this.type,
  );

  CollectionReference requests =
      FirebaseFirestore.instance.collection('requests');

  Future<void> addRequest() {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    final User user = _auth.currentUser!;
    Random random = new Random();

    return requests.doc(getRandomString(5)).set(
        {'date': date, 'time': time, 'pick-up': pickup, 'user_type': type});
  }
}
