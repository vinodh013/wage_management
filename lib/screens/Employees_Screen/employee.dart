import 'package:flutter/material.dart';
import 'package:wage_management/constants.dart';
import 'package:wage_management/controller/employee_controller.dart';
import 'package:wage_management/models/attendens.dart';
import 'package:wage_management/models/employee.dart';
import 'package:wage_management/pdf/printpdf.dart';
import 'package:wage_management/screens/Employees_Screen/add_employee.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EmployeeScreen> {
  var getcontroller = Get.put(AddEmployeeController());

  int emp = 0;

  @override
  void initState() {
    super.initState();

    getcontroller.employeelength().then((value) {
      setState(() {
        emp = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(220.h),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.h),
          child: SingleChildScrollView(
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
                          "$emp",
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Search People',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(width: 2.w))),
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
              SizedBox(
                height: 20.h,
              ),
              const Divider(),
            ]),
          ),
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
                      if (snapshot.hasData) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Slidable(
                            //  key: ValueKey(0),
                            key: const ValueKey(0),
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
                              motion: const ScrollMotion(),
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
                                  snapshot.data!.employees[index].profilePic ==
                                          ""
                                      ? CircleAvatar(
                                          child: ClipRRect(
                                              child: Image.asset(
                                            "assets/images/profilepic_default.png",
                                            fit: BoxFit.cover,
                                          )),
                                        )
                                      : CircleAvatar(
                                          child: ClipOval(
                                            child: Image.network(
                                              snapshot.data!.employees[index]
                                                  .profilePic
                                                  .toString(),
                                              fit: BoxFit.cover,
                                            ),

                                            // scale: 0.5,
                                          ),
                                        ),
                              onTap: (() => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                          height: 120.h,
                                          width: 250.w,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0.w),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
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
                                                          .at.isEmpty) {
                                                        Get.snackbar('No data',
                                                            'selected employee has no data');

                                                    
                                                      } else if(attendenceController.at.isNotEmpty) {
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
                      return const CircularProgressIndicator();
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
