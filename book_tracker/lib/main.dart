import 'package:book_tracker/screens/get_started_page.dart';
import 'package:book_tracker/screens/login_page.dart';
import 'package:book_tracker/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User firebaseUser = FirebaseAuth.instance.currentUser;
    Widget widget;
    if (firebaseUser != null) {
      widget = MainScreenPage();
    } else {
      widget = LoginPage();
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BookTracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: widget);
  }
}
