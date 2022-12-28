import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';
import 'package:wage_management/constants.dart';
import 'package:wage_management/models/attendens.dart';
import 'package:wage_management/widgets/textformfield.dart';

class AddAttendenceBottomSheet extends StatefulWidget {
  const AddAttendenceBottomSheet({super.key});

  @override
  State<AddAttendenceBottomSheet> createState() =>
      _AddAttendenceBottomSheetState();
}

class _AddAttendenceBottomSheetState extends State<AddAttendenceBottomSheet> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController projectsController = TextEditingController();
  TextEditingController timeInController = TextEditingController();
  TextEditingController timeOutController = TextEditingController();
  TextEditingController overTimeController = TextEditingController();

  String? selectedValue;

  List<SearchFieldListItem> emplval = [];
  List<SearchFieldListItem> prjval = [];

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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextInputField(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100))
                      .then((value) {
                    if (value != null) {
                      var selectedday = DateFormat('dd-M-yyyy').format(value);
                      datecontroller.text = selectedday;
                    } else {
                      return GetSnackBar(
                        message: value.toString(),
                      );
                    }
                  });
                },
                color: const Color.fromARGB(217, 217, 217, 217),
                validate: (value) {},
                controller: datecontroller,
                labelText: 'Date',
                textInputType: TextInputType.datetime),
            const SizedBox(
              height: 20,
            ),
            SearchField(
              controller: namecontroller,
              searchInputDecoration: const InputDecoration(
                hintText: 'Add Name',
                filled: true,
                fillColor: Color.fromARGB(217, 217, 217, 217),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                ),
              ),
              marginColor: Colors.transparent,
              focusNode: FocusNode(),
              itemHeight: 50,
              autoCorrect: true,
              suggestions: emplval,
              hasOverlay: true,
            ),
            const SizedBox(
              height: 20,
            ),
            SearchField(
              controller: projectsController,
              searchInputDecoration: const InputDecoration(
                hintText: 'Add Project',
                filled: true,
                fillColor: Color.fromARGB(217, 217, 217, 217),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                ),
              ),
              marginColor: Colors.transparent,
              // suggestionsDecoration: BoxDecoration(
              //   image:
              //       DecorationImage(image: networkImage('') as ImageProvider),
              //   borderRadius: BorderRadius.circular(20),
              // ),
              focusNode: FocusNode(),
              itemHeight: 50,
              autoCorrect: true,
              suggestions: prjval,
              hasOverlay: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextInputField(
                      color: const Color.fromARGB(217, 217, 217, 217),
                      validate: (value) {},
                      onTap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          if (value != null) {
                            timeInController.text = value.format(context);
                          }
                        });
                      },
                      controller: timeInController,
                      labelText: 'Time In',
                      textInputType: TextInputType.datetime),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextInputField(
                      onTap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          if (value != null) {
                            timeOutController.text = value.format(context);
                          }
                        });
                      },
                      color: const Color.fromARGB(217, 217, 217, 217),
                      validate: (value) {},
                      controller: timeOutController,
                      labelText: 'Time out',
                      textInputType: TextInputType.datetime),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextInputField(
                      color: const Color.fromARGB(217, 217, 217, 217),
                      validate: (value) {},
                      controller: overTimeController,
                      labelText: 'Overtime',
                      textInputType: TextInputType.datetime),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          const ContinuousRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              side: BorderSide(width: 1))),
                      elevation: MaterialStateProperty.all(1),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 25))),
                  onPressed: () {
                    attendenceController.addAttendenceToFirestore(
                        date: datecontroller.text,
                        attendence: Attendents(
                            name: namecontroller.text,
                            date: datecontroller.text,
                            project: projectsController.text,
                            timeIn: timeInController.text,
                            timeOut: timeOutController.text,
                            overTime:
                                int.parse(overTimeController.value.text)));

                    datecontroller.clear();
                    namecontroller.clear();
                    projectsController.clear();
                    timeInController.clear();
                    timeOutController.clear();
                    overTimeController.clear();

                    Navigator.pop(context);
                  },
                  child: const Center(
                    child: Text('Save'),
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
