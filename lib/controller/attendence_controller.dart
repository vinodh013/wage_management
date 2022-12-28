import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:wage_management/constants.dart';
import 'package:wage_management/models/employee.dart';
import 'package:wage_management/pdf/printpdf.dart';
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
    
    if (fireStore.collection('daily attendence').doc(date).id == date) {
      await fireStore.collection('daily attendence').doc(date).update({
        "attendece": FieldValue.arrayUnion([attendence.toMap()])
      });
    } else {
      fireStore.collection('daily attendence').doc(date).set({
        'attendece': [attendence.toMap()]
      });
    }
  }

  deleteAttendence({required String date, required Attendents attendence}) async {
      await   fireStore.collection('daily attendence').doc(date).update({
        'attendece': FieldValue.arrayRemove([attendence.toMap()])
      });
  }

  //? attendence queris

  //**get all attendence based on date */

  Future<AllAttendents> getallattendence(String date) async {
    try {
      AllAttendents v = await fireStore
          .collection('daily attendence')
          .doc(date)
          .get()
          .then((value) {
        return AllAttendents.fromMap(value.data()!);
      });

      return v;
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

    // for (var element in days) {
    //   docs.doc(element).get().then(
    //       (value) {
    //         if (value.data() == null) {
    //         } else {
    //           at.add(AllAttendents.fromMap(value.data()!));

    //         }
    //       },
    //     );

    // }

    //  for (var element in at) {
    //   element.allAttendents.removeWhere(
    //     (element) => element.project != name,
    //   );
    // }

    // for (var element in days) {
    //   await docs.doc(element).get().then(
    //     (value) {
    //       if (value.data() == null) {
    //       } else {
    //         at.add(AllAttendents.fromMap(value.data()!));

    //       }

    //     },
    //   );
    // }

    await Future.forEach(days, (element) async {
      var value = await docs.doc(element).get();
      if (value.data() != null) {
        at.add(AllAttendents.fromMap(value.data()!));
      }
      // print(at);
    });

    for (var element in at) {
      element.allAttendents.removeWhere(
        (element) => element.name != name,
      );
    }

    print(at);

   // return at;
  }
}
