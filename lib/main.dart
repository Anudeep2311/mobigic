import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobigic_assignment/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anudeep Lohogaonkar',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purpleAccent.shade100,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
