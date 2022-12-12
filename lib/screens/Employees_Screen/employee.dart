import 'package:flutter/material.dart';
import 'package:wage_management/controller/add_employee_controller.dart';
import 'package:wage_management/screens/Employees_Screen/add_employee.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EmployeeScreen> {
  var getcontroller = Get.put(AddEmployeeController());
  var emp = 45;

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
                    children:  [
                    const   Text(
                        'Total Employees : ' ,
                        style:  TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                       Text(
                        '$emp' ,
                        style:  TextStyle(
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
                        builder: (context) =>  AddEmployee(),
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
            const Divider()
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
                      if(snapshot.hasData){
                        
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Slidable(
                          key: ValueKey(0),
                          endActionPane: ActionPane(
                            dismissible: DismissiblePane(onDismissed: () {}),
                            motion: ScrollMotion(),
                            children: [
                              // A SlidableAction can have an icon and/or a label.
                              SlidableAction(
                                onPressed: ((context) {}),
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),

                          child: ListTile(
                            onTap: () {},
                            title: Text(snapshot.data!.employees[index].name),
                            trailing: Text(
                              snapshot.data!.employees[index].salary.toString(),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }
                return const Text('loading data');
              }),
            ),
          ],
        ),
      ),
    );
  }
}
