import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wage_management/constants.dart';
import 'package:wage_management/controller/add_employee_controller.dart';
import 'package:wage_management/controller/attendence_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndx = 0;

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (idx) {
              setState(() {
                pageIndx = idx;
                if (idx == 2) {
                 
                  Get.delete<AttendenceController>();
                } else if (idx == 1) {
                 
                Get.delete<AddEmployeeController>();
                } else if (idx == 0){
                Get.delete<AddEmployeeController>();
                  Get.delete<AttendenceController>();

                   
                }
              });
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: pageIndx,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard,
                  size: 30,
                ),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 32,
                ),
                label: "Add",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 30,
                ),
                label: "Employee's",
              ),
            ]),
        body: pages[pageIndx]);
  }
}
