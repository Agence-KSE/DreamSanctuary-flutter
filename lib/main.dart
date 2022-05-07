import 'package:flutter/material.dart';
import 'package:dreamsanctuary/login.dart';

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
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 54, 79, 107),
          foregroundColor: Color.fromARGB(255, 228, 249, 245),
        ),
      ),
      //home: const DefaultList(),
      home: Login(),
    );
  }
}
