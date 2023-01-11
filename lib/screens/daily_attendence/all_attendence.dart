import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';
import 'package:wage_management/constants.dart';
import 'package:wage_management/models/attendens.dart';
import 'package:wage_management/screens/daily_attendence/add_attendence_bottomsheet.dart';
import 'package:wage_management/widgets/custom_list_tile.dart';
import '../../controller/attendence_controller.dart';
import '../../widgets/textformfield.dart';

class TotalAttendenceScreen extends StatefulWidget {
  const TotalAttendenceScreen({super.key});

  @override
  State<TotalAttendenceScreen> createState() => _TotalAttendenceScreenState();
}

class _TotalAttendenceScreenState extends State<TotalAttendenceScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController projectsController = TextEditingController();
  TextEditingController timeInController = TextEditingController();
  TextEditingController timeOutController = TextEditingController();
  TextEditingController overTimeController = TextEditingController();

  List<SearchFieldListItem> emplval = [];
  List<SearchFieldListItem> prjval = [];

  String? selectedValue;

  var attendenceController = Get.put(AttendenceController());
  //String? selectedday;

  var isdissmisable = false;

  Future<AllAttendents>? allat;

  var selectedday = DateFormat('dd-M-yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();

    addEmployeeController
        .getEmployees()
        .then((value) => value.employees.forEach((element) {
              emplval.add(SearchFieldListItem(element.name));
            }));

    projectController
        .getProjects()
        .then((value) => value.projects.forEach((element) {
              prjval.add(SearchFieldListItem(element.name));
            }));
  }

  @override
  Widget build(context) {
    allat = attendenceController.getallattendence(selectedday);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      ).then(
                        (value) async {
                          setState(() {
                            selectedday = DateFormat('dd-M-yyyy')
                                .format(value ?? DateTime.now());
                          });
                        },
                      );
                    },
                    icon: const Icon(Icons.filter_alt),
                    label: Text(
                      selectedday,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    )),
                TextButton(
                    child: const Text(
                      'Add Attendents',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () async {
                      await showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return AddAttendenceBottomSheet(
                              onpress: () {
                                attendenceController.addAttendenceToFirestore(
                                  date: datecontroller.text,
                                  attendence: Attendents(
                                    name: namecontroller.text,
                                    date: datecontroller.text,
                                    project: projectsController.text,
                                    timeIn: timeInController.text,
                                    timeOut: timeOutController.text,
                                    overTime: int.parse(
                                        overTimeController.value.text),
                                  ),
                                );

                                Navigator.pop(context);

                                setState(() {});
                              },
                              emplval: emplval,
                              prjval: prjval,
                              nameController: namecontroller,
                              dateController: datecontroller,
                              overTimeController: overTimeController,
                              projectsController: projectsController,
                              timeInController: timeInController,
                              timeOutController: timeOutController,
                            );
                          });

                      setState(() {});
                    })
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            FutureBuilder(
              future: allat,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.allAttendents.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (snapshot.hasData) {
                          return CustomListTile(
                              date: snapshot.data!.allAttendents[index].name,
                              projectname:
                                  snapshot.data!.allAttendents[index].project,
                              onPressed: () async {
                                await attendenceController.deleteAttendence(
                                    date: snapshot
                                        .data!.allAttendents[index].date,
                                    attendence: Attendents(
                                      name: snapshot
                                          .data!.allAttendents[index].name,
                                      date: snapshot
                                          .data!.allAttendents[index].date,
                                      project: snapshot
                                          .data!.allAttendents[index].project,
                                      timeIn: snapshot
                                          .data!.allAttendents[index].timeIn,
                                      timeOut: snapshot
                                          .data!.allAttendents[index].timeOut,
                                      overTime: snapshot
                                          .data!.allAttendents[index].overTime,
                                    ));

                                setState(() {});
                              });
                        }

                        return Text('loading');
                      });
                }

                return Center(
                  child: Text(snapshot.data.toString()),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    datecontroller.dispose();
    namecontroller.dispose();
    projectsController.dispose();
    timeInController.dispose();
    timeOutController.dispose();
    overTimeController.dispose();
  }
}
