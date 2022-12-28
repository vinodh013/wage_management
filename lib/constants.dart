import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wage_management/controller/employee_controller.dart';
import 'package:wage_management/controller/attendence_controller.dart';
import 'package:wage_management/controller/project_controller.dart';
import 'package:wage_management/screens/Employees_Screen/employee.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wage_management/screens/daily_attendence/all_attendence.dart';
import 'package:wage_management/screens/project_screen/project_screen.dart';


const pages = [
  EmployeeScreen(),
  TotalAttendenceScreen(),
  ProjectScreen(),
 
];


const borderColor = Colors.grey;

typedef image = Future<Map<String, Uint8List>>;



//Firebase
//var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var fireStore = FirebaseFirestore.instance;

// Controller
var addEmployeeController = AddEmployeeController.instance;
var attendenceController = AttendenceController.instance;
var projectController = ProjectController.instance;


