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
    return  GetMaterialApp(
    
      theme: ThemeData.from(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 225, 98, 98),
          onPrimary: Colors.black,
          secondary:  Colors.redAccent,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.black,
          background: Color.fromARGB(255, 232, 224, 224),
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
       
        useMaterial3: true
      ),
      debugShowCheckedModeBanner: false,
      title: 'Wage Management',
      home: HomeScreen(),
    );
  }
}
