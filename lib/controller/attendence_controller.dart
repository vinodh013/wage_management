import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wage_management/constants.dart';
import 'package:wage_management/models/employee.dart';
import '../models/attendens.dart';

class AttendenceController extends GetxController {
  static AttendenceController instance = Get.put(AttendenceController());

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

  addAttendenceToFirestore(
      {required String date, required Attendents attendence}) async {
    fireStore.collection('daily attendence').doc(date).get().then((value) => {
          if (value.data() != null)
            {
              fireStore.collection('daily attendence').doc(date).update({
                "attendece": FieldValue.arrayUnion([attendence.toMap()])
              })
            }
          else
            {
              fireStore.collection('daily attendence').doc(date).set({
                'attendece': [attendence.toMap()]
              })
            }
        });
  }

  deleteAttendence(
      {required String date, required Attendents attendence}) async {
    await fireStore.collection('daily attendence').doc(date).update({
      'attendece': FieldValue.arrayRemove([attendence.toMap()])
    });
  }

  //? attendence queris

  //**get all attendence based on date */

  Future<AllAttendents> getallattendence(String date) async {
    try {
      var v = await fireStore
          .collection('daily attendence')
          .doc(date)
          .get()
          .then((value) {
        return value.data();
      });

      return AllAttendents.fromMap(v ?? {});
    } catch (e) {
      throw e.toString();
    }
  }

  List<AllAttendents> at = <AllAttendents>[];

  getAttendenceByName(DateTime startDate, DateTime endDate, String name) async {
    var docs = fireStore.collection('daily attendence');
    // final PdfGrid grid = PdfGrid();

    List<String> days = [];

    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      var f = startDate.add(Duration(days: i));

      days.add(DateFormat('dd-M-yyyy').format(f));
    }

    for (var element in days) {
      await docs.doc(element).get().then(
        (value) {
          if (value.data() == null) {
          } else {
            at.add(AllAttendents.fromMap(value.data()!));
          }
        },
      );
    }

    for (var element in at) {
      element.allAttendents.removeWhere(
        (element) => element.name != name,
      );
    }

    at.removeWhere(
      (element) =>  element == AllAttendents(allAttendents: [])
    );

    print(at);
  }
}
