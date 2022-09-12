import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//recieves all the necessary info of a student and adds to the student collection in firebase
class AddTeacher {
  final _auth = FirebaseAuth.instance;

  late final String userName;
  late final String fullName;
  late final String id;
  late final String email;
  late final String phone;
  late final String pickup;
  late final String codeName;
  late final String dept;
  late final String designation;

  AddTeacher(
    this.userName,
    this.fullName,
    this.id,
    this.email,
    this.phone,
    this.pickup,
    this.codeName,
    this.dept,
    this.designation,
  );

  CollectionReference students =
      FirebaseFirestore.instance.collection('teachers');
  Future<void> addTeacher() {
    final User user = _auth.currentUser!;
    return students.doc(user.uid).set({
      'user_name': userName,
      'full_name': fullName,
      'id': id,
      'uid': user.uid,
      'user type': 'teacher',
      'email': email,
      'phone': phone,
      'pickup': pickup,
      'code_name': codeName,
      'dept': dept,
      'designation': designation,
    });
  }
}
