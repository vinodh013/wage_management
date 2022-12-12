import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wage_management/constants.dart';
import 'package:wage_management/models/employee.dart';
import '../models/attendens.dart';

class AttendenceController extends GetxController {
  static AttendenceController instance = Get.find();

  late TotalAttendents listOfAttendence = TotalAttendents(attendents: []);

  updateAttendenc(int index, int hours) {
    listOfAttendence.attendents.elementAt(index).noOfHours = hours;
  }

  //? FIREBASE functions

  Future<Employees> getEmployeesName() async {
    var employees = await fireStore
        .collection("Employees")
        .doc("Employees")
        .get()
        .then((value) => value.data()!);

    var em = Employees.fromMap(employees);

    return em;
  }

  addAttendenceToFirestore(String date, TotalAttendents attendence) async {
    fireStore.collection('daily attendence').doc(date).set(attendence.toMap());
  }

  @override
  void onClose() {
    AttendenceController().dispose();
    super.onClose();
  }

  // Remove attendence

  // update attendence

  //? attendence queris

  //**get all attendence based on date */

  Future<TotalAttendents> filteredAttendence([String? date]) async {
    var fetchCollection = fireStore.collection('daily attendence');

    // var jsonsource;

    var jsonsource =
        await fetchCollection.doc(date).get().then((value) => value.data()!);

    return TotalAttendents.fromMap(jsonsource);
  }

  Set<String> docdate = Set<String>();

  List<String> docId = [];

  Future<List<TotalAttendents>> getallattendence([String? date]) async {
    //= List<String> docId =  [];

    var newcollection = <TotalAttendents>[];

    await fireStore.collection('daily attendence').get().then((value) => {
          value.docs.forEach((element) async {
            docId.add(date ?? element.id);
          })
        });
    // print(att.toString());
    //  print(docId);

    for (var element in docId.toSet().toList()) {
      await fireStore.collection('daily attendence').doc(element).get().then(
          (value) => newcollection.add(TotalAttendents.fromMap(value.data()!)));
    }

    return newcollection;
  }
}
