import '../../screens/ride_pref/ride_pref_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlaBlaCar Clone',
      theme: ThemeData(
        primaryColor: const Color(0xFF00AAE4),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const RidePrefScreen(), // Original home
    );
  }
}
