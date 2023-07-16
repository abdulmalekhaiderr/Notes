import 'package:flutter/material.dart';
import 'package:notes/addnotes.dart';
import 'package:notes/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "addnotes",
      home: Home(),
      debugShowCheckedModeBanner: false,
      routes: {
        "addnotes": (context) => AddNotes(),
      },
    );
  }
}
