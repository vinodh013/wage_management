import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:wage_management/constants.dart';
import 'package:wage_management/controller/employee_controller.dart';
import 'package:wage_management/models/attendens.dart';
import 'package:wage_management/models/employee.dart';
import 'package:wage_management/pdf/printpdf.dart';
import 'package:wage_management/screens/Employees_Screen/add_employee.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wage_management/screens/daily_attendence/all_attendence.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EmployeeScreen> {
  var getcontroller = Get.put(AddEmployeeController());
  int emp = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(220),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      const Text(
                        'Total Employees : ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '$emp',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEmployee(),
                      ),
                    );
                  },
                  child: const Text(
                    'Add Employees',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Search People',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 2))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Salary',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
          ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
              future: getcontroller.getEmployees(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.employees.length,
                    itemBuilder: ((context, index) {
                      emp = snapshot.data!.employees.length;
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Slidable(
                            //  key: ValueKey(0),
                            key: ValueKey(0),
                            endActionPane: ActionPane(
                              dismissible: DismissiblePane(onDismissed: () {
                                addEmployeeController.deleteEmployee(
                                  Employee(
                                    name: snapshot.data!.employees[index].name,
                                    salary:
                                        snapshot.data!.employees[index].salary,
                                    phoneNumber: snapshot
                                        .data!.employees[index].phoneNumber,
                                    profilePic: snapshot
                                        .data!.employees[index].profilePic,
                                    description: snapshot
                                        .data!.employees[index].description,
                                  ),
                                );
                              }),
                              motion: ScrollMotion(),
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: ((context) {
                                    addEmployeeController.deleteEmployee(
                                      Employee(
                                        name: snapshot
                                            .data!.employees[index].name,
                                        salary: snapshot
                                            .data!.employees[index].salary,
                                        phoneNumber: snapshot
                                            .data!.employees[index].phoneNumber,
                                        profilePic: snapshot
                                            .data!.employees[index].profilePic,
                                        description: snapshot
                                            .data!.employees[index].description,
                                      ),
                                    );

                                    setState(() {});
                                  }),
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading:
                                  snapshot.data!.employees[index].profilePic !=
                                          null
                                      ? CircleAvatar(
                                          child: ClipRRect(
                                            
                                            
                                            child: Image.network(
                                              snapshot.data!.employees[index]
                                                  .profilePic
                                                  .toString(),
                                              fit: BoxFit.contain,
                                            ),

                                            // scale: 0.5,
                                          ),
                                        )
                                      : CircleAvatar(
                                          child: ClipRRect(
                                              child: Image.asset(
                                            "assets/images/profilepic_default.png",
                                            fit: BoxFit.cover,
                                          )),
                                        ),
                              onTap: (() => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                          height: 100,
                                          width: 300,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                MaterialButton(
                                                  onPressed: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return TotalAttendenceScreen();
                                                      },
                                                    ));
                                                  },
                                                  child: Container(
                                                    child: const Center(
                                                      child: Text('Attendence'),
                                                    ),
                                                  ),
                                                ),
                                                const Divider(),
                                                MaterialButton(
                                                  onPressed: () async {
                                                    showDateRangePicker(
                                                      currentDate:
                                                          DateTime.now(),
                                                      context: context,
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2100),
                                                    ).then((value) async {
                                                      await attendenceController
                                                          .getAttendenceByName(
                                                        value!.start,
                                                        value.end,
                                                        snapshot
                                                            .data!
                                                            .employees[index]
                                                            .name,
                                                      );

                                                      if (attendenceController
                                                          .at
                                                          .contains(
                                                        AllAttendents(
                                                          allAttendents: [],
                                                        ),
                                                      )) {
                                                        Get.snackbar('No Data',
                                                            'Selected Employee has no data between these dates');

                                                        attendenceController.at
                                                            .clear();
                                                      } else {
                                                        await createPDF();

                                                        attendenceController.at
                                                            .clear();
                                                      }
                                                    });
                                                  },
                                                  child: const Center(
                                                    child: Text('Report'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                              title: Text(snapshot.data!.employees[index].name),
                              trailing: Text(
                                snapshot.data!.employees[index].salary
                                    .toString(),
                              ),
                            ),
                          ),
                        );
                      }
                      return CircularProgressIndicator();
                    }),
                  );
                }
                return const Center(child: Text('loading data'));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
