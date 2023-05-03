import 'package:flutter/material.dart';
import 'package:movies_tp/AddMovie.dart';
import 'package:movies_tp/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      home: const Home(),
      routes: {
        "AddMovie":(context)=>AddMovie()
      },
    );
  }
}
