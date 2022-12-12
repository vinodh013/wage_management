import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/attendence_controller.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final attendenceController = Get.put(AttendenceController());

  @override
  void initState() {
    // attendenceController.getallattendence();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),

        // color: const Color.fromARGB(255, 204, 189, 189),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Select Date :',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    height: 20,
                    width: 100,
                    child: DatePickerDialog(
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list_alt),
                  label: const Text(
                    'Filter',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )),
            )
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Date',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Attended',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Amount',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            //width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              'Detailed List',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),

              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Amount',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              //width: double.infinity,
            ),
          )
        ],
      ),
    );
  }
}
