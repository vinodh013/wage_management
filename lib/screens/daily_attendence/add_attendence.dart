import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wage_management/controller/attendence_controller.dart';
import 'package:wage_management/models/attendens.dart';
import 'package:wage_management/screens/daily_attendence/all_attendence.dart';
import 'package:wage_management/screens/daily_attendence/counter_tile.dart';

class AddAttendence extends StatelessWidget {
  const AddAttendence({super.key});

  @override
  Widget build(BuildContext context) {
    final attendenceController = Get.put(AttendenceController());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 189, 189),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
            color: const Color.fromARGB(255, 204, 189, 189),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Date :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    height: 20,
                    width: 100,
                    child: DatePickerDialog(
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ),
                  ),
                ],
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(TotalAttendenceScreen());
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        var attendenceDate =
                            DateFormat('dd-M-yyyy').format(DateTime.now());
                        attendenceController.addAttendenceToFirestore(
                            attendenceDate,
                            attendenceController.listOfAttendence);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                  future: attendenceController.getEmployeesName(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.employees.length,
                        itemBuilder: (context, index) {
                          var val = index;
                          attendenceController.listOfAttendence.attendents.add(
                            Attendents(
                                name: snapshot.data!.employees[index].name,
                                noOfHours: 0),
                          );
                          return Container(
                            margin: const EdgeInsets.all(10),
                            child: CounterTile(
                              index: val,
                              attendencecontroller: attendenceController,
                              name: snapshot.data!.employees[index].name,
                              number: 0,
                            ),
                          );
                        },
                      );
                    } else {
                      return Container(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    }
                  }))
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   var attendenceDate = DateFormat('dd-M-yyyy').format(DateTime.now());
      //   attendenceController.addAttendenceToFirestore(
      //       attendenceDate, attendenceController.listOfAttendence);
      // }
      // ),
    );
  }
}
