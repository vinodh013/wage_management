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

}
