import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wage_management/controller/attendence_controller.dart';
import 'package:wage_management/models/attendens.dart';
import 'package:wage_management/screens/daily_attendence/counter_tile.dart';

class AddAttendence extends StatelessWidget {
  const AddAttendence({super.key});

  @override
  Widget build(BuildContext context) {
    final attendenceController = Get.put(AttendenceController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (() {
                    Get.to(DatePickerDialog(
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ));
                  }),
                  child: Container(
                    width: 120,
                    height: 40,
                    color: Colors.red,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  // width: 120,
                  height: 40,

                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Center(
                      child: Text(
                        'Add Attendence',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
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
                  }
                  return const Text('loading');
                }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        var attendenceDate = DateFormat('dd-M-yyyy').format(DateTime.now());
        attendenceController.addAttendenceToFirestore(
            attendenceDate, attendenceController.listOfAttendence);
      }),
    );
  }
}
