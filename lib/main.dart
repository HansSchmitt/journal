import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Journal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomAppBarColor: Colors.lightGreen,
        canvasColor: Colors.lightGreen.shade50,
      ),
      home: Home(),
    );
  }
}
