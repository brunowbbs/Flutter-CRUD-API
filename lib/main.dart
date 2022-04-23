import 'package:cleanarch/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.orange,
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
