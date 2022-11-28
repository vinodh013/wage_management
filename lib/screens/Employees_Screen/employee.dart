import 'package:flutter/material.dart';
import 'package:wage_management/controller/add_employee_controller.dart';
import 'package:wage_management/screens/Employees_Screen/add_employee.dart';
import 'package:get/get.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EmployeeScreen> {
  var getcontroller = Get.put(AddEmployeeController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 35,
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
                  )),
            ),
          ),
          Align(
            widthFactor: 4,
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const  AddEmployee(),
                  ),
                );
              },
              child: const Text(
                'Add Employee',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    wordSpacing: 1.8),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          FutureBuilder(
            future: getcontroller.getEmployees(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.employees.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        shadowColor: const Color.fromARGB(255, 29, 29, 29),
                        elevation: 1,
                        child: ExpansionTile(
                          title: Text(snapshot.data!.employees[index].name),
                          children: [
                            SizedBox(
                              height: 50,
                              child: Text(snapshot.data!.employees[index].salary
                                  .toString()),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  ),
                );
              }
              return const Text('loading data');
            }),
          ),
        ],
      ),
    );
  }
}
