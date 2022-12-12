import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wage_management/screens/daily_attendence/add_attendence.dart';

import '../../controller/attendence_controller.dart';

class TotalAttendenceScreen extends StatefulWidget {
  const TotalAttendenceScreen({super.key});

  @override
  State<TotalAttendenceScreen> createState() => _TotalAttendenceScreenState();
}

class _TotalAttendenceScreenState extends State<TotalAttendenceScreen> {
  final attendenceController = Get.put(AttendenceController());
  String? selectedday;

  // @override
  // void initState() {
  //   selectedday = '';
  // //  attendenceController.filteredAttendence('');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                            selectedday =
                                 DateFormat('dd-M-yyyy').format(value!);

                            if (attendenceController.docId
                                .contains(selectedday)) {
                              setState(
                                ()  {
                                  for (var element in attendenceController.docId)  {
                                    if (element != selectedday)  {
                                       attendenceController.docId
                                          .remove(element);
                                    }
                                  }
                                  attendenceController
                                      .getallattendence(selectedday);
                                },
                              );
                            }
                          },
                        );
                      },
                      icon: const Icon(Icons.filter_alt),
                      label: const Text(
                        'Filter Dates',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) {
                            return const AddAttendence();
                          }),
                        ),
                      );
                    },
                    child: const Text(
                      'Add Attendents',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder(
                  future: selectedday != null
                      ? attendenceController.getallattendence(selectedday)
                      : attendenceController.getallattendence(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: ((context, index) {
                          var n = [];
                          var p = [];
                          snapshot.data![index].attendents.forEach(
                            (element) {
                              if (element.noOfHours > 0) {
                                n.add(element.noOfHours);
                              }
                            },
                          );
                          snapshot.data![index].attendents.forEach(
                            (element) {
                              p.add(element.noOfHours);
                            },
                          );

                          return customListTile(
                              context,
                              attendenceController.docId[index],
                              '${p.length}/ ${n.length}');

                          //  Container(
                          //   height: 100,
                          //   width: 100,
                          //   color: Color.fromRGBO(255, 255, 255, 1),
                          //   child: Row(
                          //     children: [
                          //      Text(attendenceController.docId[index]),
                          //       Text(
                          //           '${p.length}/ ${n.length}'),
                          //     ],
                          //   ),
                          // );
                        }  
                        
                        
                        ),
                      );
                    } else if(snapshot.hasError){
                       const Center(
                         child: Text('Error'),
                       );
                    }
                    return const Center(
                      child: Text('Loading'),
                    );
                    // var n = [];
                    // snapshot.data!.forEach((element) {
                    //   n.add(element.attendents);
                    // });

                    // if (snapshot.hasData) {
                    //   return ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: snapshot.data!.length,
                    //     itemBuilder: (context, index) {

                    //       List n = [];
                    //       snapshot.data![index].attendents.forEach((element) {
                    //         if (element.noOfHours > 0) {
                    //           n.add(element.noOfHours);
                    //         }
                    //       });
                    //       List b = [];

                    //       snapshot.data![index].attendents.forEach((element) {
                    //           b.add(element.noOfHours);
                    //       });

                    //       return customListTile(
                    //         context,
                    //         selectedday,
                    //         ' ${snapshot.data![index].attendents[index].noOfHours}/ ${n.length} ',
                    //       );
                    //     },
                    //   );
                    // } else {
                    //   return Container();
                    // }
                  }),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customListTile(BuildContext context, String date, String total) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(20),
      height: 65,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date),
          Text(total),
          TextButton(onPressed: () {}, child: const Text('Edit'))
        ],
      ),
    );
  }

  @override
  void dispose() {
    attendenceController.docId.clear();
    super.dispose();
  }
}
