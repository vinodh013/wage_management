import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wage_management/firebase_options.dart';
import 'package:wage_management/screens/Employees_Screen/add_employee.dart';
import 'package:wage_management/screens/Homepage.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wage Management',
      home: HomeScreen(),
    );
  }
}
