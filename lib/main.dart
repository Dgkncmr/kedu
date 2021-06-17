import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kedu/ui/pages/signInPages/signInParentPage.dart';
import 'package:kedu/ui/pages/signUpPages/signUpPage.dart';
import 'package:kedu/ui/pages/teacherPages/homePageTeacher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      home: SignUpPage()));
}
