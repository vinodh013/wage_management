import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';
import 'package:wage_management/constants.dart';
import 'package:wage_management/widgets/textformfield.dart';

class AddAttendenceBottomSheet extends StatelessWidget {
  AddAttendenceBottomSheet(
      {super.key,
      required this.onpress,
      required this.nameController,
      required this.dateController,
      required this.overTimeController,
      required this.projectsController,
      required this.timeInController,
      required this.timeOutController,
      required this.emplval,
      required this.prjval});

  void Function() onpress;
  TextEditingController nameController;
  TextEditingController dateController;
  TextEditingController projectsController;
  TextEditingController timeInController;
  TextEditingController timeOutController;
  TextEditingController overTimeController;

  List<SearchFieldListItem> emplval;
  List<SearchFieldListItem> prjval;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r))),
        padding: EdgeInsets.only(
            top: 10,
            right: 22,
            left: 22,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            TextInputField(
                authfocus: true,
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100))
                      .then((value) {
                    if (value != null) {
                      var selectedday = DateFormat('dd-M-yyyy').format(value);
                      dateController.text = selectedday;
                    } else {
                      return GetSnackBar(
                        message: value.toString(),
                      );
                    }
                  });
                },
                color: const Color.fromARGB(217, 217, 217, 217),
                validate: (value) {},
                controller: dateController,
                labelText: 'Date',
                textInputType: TextInputType.datetime),
            SizedBox(
              height: 20.h,
            ),
            SearchField(
              controller: nameController,
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
              itemHeight: 50.h,
              autoCorrect: true,
              suggestions: emplval,
              hasOverlay: true,
            ),
            SizedBox(
              height: 20.h,
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
              focusNode: FocusNode(),
              itemHeight: 50.h,
              autoCorrect: true,
              suggestions: prjval,
              hasOverlay: true,
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextInputField(
                      authfocus: true,
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
                SizedBox(
                  width: 20.h,
                ),
                Expanded(
                  child: TextInputField(
                      authfocus: true,
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
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextInputField(
                      authfocus: true,
                      color: const Color.fromARGB(217, 217, 217, 217),
                      validate: (value) {},
                      controller: overTimeController,
                      labelText: 'Overtime',
                      textInputType: TextInputType.datetime),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                    child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        side: BorderSide(width: 1),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(1),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 25.h),
                    ),
                  ),
                  onPressed: onpress,
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

// class AddAttendenceBottomSheet extends StatefulWidget {
//   AddAttendenceBottomSheet({
//     super.key,
//     required this.onpress,
//     required this.nameController,
//     required this.dateController,
//     required this.overTimeController,
//     required this.projectsController,
//     required this.timeInController,
//     required this.timeOutController,
//   });

//   void Function() onpress;
//   TextEditingController nameController;
//   TextEditingController dateController;
//   TextEditingController projectsController;
//   TextEditingController timeInController;
//   TextEditingController timeOutController;
//   TextEditingController overTimeController;

//   @override
//   State<AddAttendenceBottomSheet> createState() =>
//       AddAttendenceBottomSheetState();
// }

// class AddAttendenceBottomSheetState extends State<AddAttendenceBottomSheet> {
//  String? selectedValue;

//   List<SearchFieldListItem> emplval = [];
//   List<SearchFieldListItem> prjval = [];

//   @override
//   void initState() {
//     super.initState();
//     addEmployeeController
//         .getEmployees()
//         .then((value) => value.employees.forEach((element) {
//               emplval.add(SearchFieldListItem(element.name));
//             }));

//     projectController
//         .getProjects()
//         .then((value) => value.projects.forEach((element) {
//               prjval.add(SearchFieldListItem(element.name));
//             }));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20.r),
//                 topRight: Radius.circular(20.r))),
//         padding: const EdgeInsets.symmetric(horizontal: 25),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 30.h,
//             ),
//             TextInputField(
//                 onTap: () {
//                   showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(2100))
//                       .then((value) {
//                     if (value != null) {
//                       var selectedday = DateFormat('dd-M-yyyy').format(value);
//                       widget.dateController.text = selectedday;
//                     } else {
//                       return GetSnackBar(
//                         message: value.toString(),
//                       );
//                     }
//                   });
//                 },
//                 color: const Color.fromARGB(217, 217, 217, 217),
//                 validate: (value) {},
//                 controller: widget.dateController,
//                 labelText: 'Date',
//                 textInputType: TextInputType.datetime),
//             SizedBox(
//               height: 20.h,
//             ),
//             SearchField(
//               controller: widget.nameController,
//               searchInputDecoration: const InputDecoration(
//                 hintText: 'Add Name',
//                 filled: true,
//                 fillColor: Color.fromARGB(217, 217, 217, 217),
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(width: 1),
//                 ),
//               ),
//               marginColor: Colors.transparent,
//               focusNode: FocusNode(),
//               itemHeight: 50.h,
//               autoCorrect: true,
//               suggestions: emplval,
//               hasOverlay: true,
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             SearchField(
//               controller: widget.projectsController,
//               searchInputDecoration: const InputDecoration(
//                 hintText: 'Add Project',
//                 filled: true,
//                 fillColor: Color.fromARGB(217, 217, 217, 217),
//                 border: OutlineInputBorder(
//                   borderSide: BorderSide(width: 1),
//                 ),
//               ),
//               marginColor: Colors.transparent,
//               focusNode: FocusNode(),
//               itemHeight: 50.h,
//               autoCorrect: true,
//               suggestions: prjval,
//               hasOverlay: true,
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: TextInputField(
//                       color: const Color.fromARGB(217, 217, 217, 217),
//                       validate: (value) {},
//                       onTap: () {
//                         showTimePicker(
//                                 context: context, initialTime: TimeOfDay.now())
//                             .then((value) {
//                           if (value != null) {
//                             widget.timeInController.text =
//                                 value.format(context);
//                           }
//                         });
//                       },
//                       controller: widget.timeInController,
//                       labelText: 'Time In',
//                       textInputType: TextInputType.datetime),
//                 ),
//                 SizedBox(
//                   width: 20.h,
//                 ),
//                 Expanded(
//                   child: TextInputField(
//                       onTap: () {
//                         showTimePicker(
//                                 context: context, initialTime: TimeOfDay.now())
//                             .then((value) {
//                           if (value != null) {
//                             widget.timeOutController.text =
//                                 value.format(context);
//                           }
//                         });
//                       },
//                       color: const Color.fromARGB(217, 217, 217, 217),
//                       validate: (value) {},
//                       controller: widget.timeOutController,
//                       labelText: 'Time out',
//                       textInputType: TextInputType.datetime),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: TextInputField(
//                       color: const Color.fromARGB(217, 217, 217, 217),
//                       validate: (value) {},
//                       controller: widget.overTimeController,
//                       labelText: 'Overtime',
//                       textInputType: TextInputType.datetime),
//                 ),
//                 SizedBox(
//                   width: 20.w,
//                 ),
//                 Expanded(
//                     child: ElevatedButton(
//                   style: ButtonStyle(
//                     shape: MaterialStateProperty.all(
//                       const ContinuousRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         side: BorderSide(width: 1),
//                       ),
//                     ),
//                     elevation: MaterialStateProperty.all(1),
//                     padding: MaterialStateProperty.all(
//                       EdgeInsets.symmetric(vertical: 25.h),
//                     ),
//                   ),
//                   onPressed: widget.onpress,
//                   child: const Center(
//                     child: Text('Save'),
//                   ),
//                 )),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
