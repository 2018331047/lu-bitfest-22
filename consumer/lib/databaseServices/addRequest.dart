import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//recieves all the necessary info of a student and adds to the student collection in firebase
class AddRequest {
  final _auth = FirebaseAuth.instance;

  late final String date;
  late final String time;
  late final String pickup;

  AddRequest(
    this.date,
    this.time,
    this.pickup,
  );

  CollectionReference requests =
      FirebaseFirestore.instance.collection('requests');
  Future<void> addRequest() {
    final User user = _auth.currentUser!;
    return requests
        .doc(user.uid)
        .set({'date': date, 'time': time, 'pick-up': pickup});
  }
}
