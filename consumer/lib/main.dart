import 'dart:math';

import 'package:consumer/databaseServices/addRequest.dart';
import 'package:consumer/screens/initscreens/login.dart';
import 'package:consumer/screens/tabs/busSchedule.dart';
import 'package:consumer/screens/tabs/request.dart';
import 'package:consumer/screens/tabs/tabscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
