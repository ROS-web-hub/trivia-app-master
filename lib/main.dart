import 'package:flutter/material.dart';
import 'package:quiz/pages/home.dart';
// import 'package:admob_flutter/admob_flutter.dart';

void main() {
  // Admob.initialize("a");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue, primaryColor: Color(0xFF142850)),
      home: HomePage(),
    );
  }
}
