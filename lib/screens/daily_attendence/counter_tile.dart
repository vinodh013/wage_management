import 'package:flutter/material.dart';

import 'package:wage_management/constants.dart';
import 'package:wage_management/controller/attendence_controller.dart';
import 'package:wage_management/models/attendens.dart';

class CounterTile extends StatefulWidget {
  final AttendenceController attendencecontroller;
  final String name;
  int number;
  int index;

  CounterTile({
    Key? key,
    required this.attendencecontroller,
    required this.name,
    required this.number,
    required this.index,
  }) : super(key: key);

  @override
  State<CounterTile> createState() => _CounterTileState();

  void increament() {
    number++;
  }

  void decrement() {
    if (number == 0) {
      print('sorry');
    } else {
      number--;
    }
  }

  static int val = 45;
}

class _CounterTileState extends State<CounterTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: const Color.fromARGB(250, 242, 240, 240),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.name),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.redAccent),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        widget.decrement();
                         attendenceController.updateAttendenc(
                            widget.index, widget.number);
                      });
                    },
                    icon: const Icon(Icons.remove),
                  ),
                ),
                Text(widget.number.toString()),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.redAccent),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        widget.increament();
                        attendenceController.updateAttendenc(
                            widget.index, widget.number);
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
