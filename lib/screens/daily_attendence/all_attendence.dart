import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wage_management/models/attendens.dart';
import 'package:wage_management/screens/daily_attendence/add_attendence_bottomsheet.dart';
import 'package:wage_management/widgets/custom_list_tile.dart';
import '../../controller/attendence_controller.dart';

class TotalAttendenceScreen extends StatefulWidget {
  const TotalAttendenceScreen({super.key});

  @override
  State<TotalAttendenceScreen> createState() => _TotalAttendenceScreenState();
}

class _TotalAttendenceScreenState extends State<TotalAttendenceScreen> {
  var attendenceController = Get.put(AttendenceController());
  String? selectedday;

  @override
  void initState() {
    super.initState();
    selectedday = DateFormat('dd-M-yyyy').format(DateTime.now());
  }

  // attendenceController.getallattendence(selectedday!);

  @override
  Widget build(BuildContext context) {
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
                    label: const Text(
                      'Filter Dates',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        context: context,
                        builder: ((context) {
                          return BottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            onClosing: () {},
                            builder: (context) {
                              return AddAttendenceBottomSheet();
                            },
                          );
                        }));
                  },
                  child: const Text(
                    'Add Attendents',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            FutureBuilder(
              future: attendenceController.getallattendence(selectedday!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.allAttendents.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CustomListTile(
                          date: snapshot.data!.allAttendents[index].name,
                          projectname:
                              snapshot.data!.allAttendents[index].project,
                          onPressed: () async {
                            await attendenceController.deleteAttendence(
                                date: snapshot.data!.allAttendents[index].date,
                                attendence: Attendents(
                                  name:
                                      snapshot.data!.allAttendents[index].name,
                                  date:
                                      snapshot.data!.allAttendents[index].date,
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
                    },
                  );
                } else {
                  return Center(
                    child: Text(snapshot.data.toString()),
                  );
                }

                // return const Center(
                //   child: Text(''),
                // );
              },
            )
          ],
        ),
      ),
    );
  }
}
