import 'package:flutter/material.dart';
import 'package:flutter_test_app/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dream Sanctuary',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple[700],
          foregroundColor: Colors.blueGrey[300],
        ),
      ),
      //home: const DefaultList(),
      home: Login(),
    );
  }
}
