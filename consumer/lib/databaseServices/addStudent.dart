import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//recieves all the necessary info of a student and adds to the student collection in firebase
class AddStudent {
  final _auth = FirebaseAuth.instance;

  late final String userName;
  late final String fullName;
  late final String id;
  late final String email;
  late final String phone;
  late final String pickup;
  late final String batch;
  late final String section;
  late final String dept;

  AddStudent(
    this.userName,
    this.fullName,
    this.id,
    this.email,
    this.phone,
    this.pickup,
    this.batch,
    this.section,
    this.dept,
  );

  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  Future<void> addStudent() {
    final User user = _auth.currentUser!;
    return students.doc(user.uid).set({
      'user_name': userName,
      'full_name': fullName,
      'id': id,
      'uid': user.uid,
      'user type': 'student',
      'email': email,
      'phone': phone,
      'pickup': pickup,
      'batch': batch,
      'section': section,
      'dept': dept,
    });
  }
}
