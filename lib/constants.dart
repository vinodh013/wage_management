import 'package:flutter/material.dart';
import 'package:wage_management/controller/add_employee_controller.dart';
import 'package:wage_management/controller/attendence_controller.dart';
import 'package:wage_management/screens/Employees_Screen/employee.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wage_management/screens/daily_attendence/add_attendence.dart';
import 'package:wage_management/screens/daily_attendence/total_attendence.dart';


const pages = [
  TotalAttendenceScreen(),
  //Text('Home screen'),
  AddAttendence(),
  EmployeeScreen(),
];


const borderColor = Colors.grey;



//Firebase
//var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var fireStore = FirebaseFirestore.instance;

// Controller
var addEmployeeController = AddEmployeeController.instance;
var attendenceController = AttendenceController.instance;


