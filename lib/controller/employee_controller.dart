import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:wage_management/models/employee.dart' as model;
import '../constants.dart';
import '../models/employee.dart';

class AddEmployeeController extends GetxController {
  static AddEmployeeController instance = Get.find();

  String? imagepath;
  Uint8List? pickedImages;

  // late File? pickimage;

  // get profilePhoto => _pickedImage;

  Future<Uint8List?> pickImage() async {
    // final pickedImage =
    //     await ImagePicker().pickImage(source: ImageSource.gallery);

    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();

    if (fileResult != null) {
      Get.snackbar('Profile Picture', "Picture selected");
    }

    imagepath = fileResult!.files.first.name;

    print(imagepath);

    return pickedImages = fileResult.files.first.bytes;
    // var uploadfile = await pickedImage.readAsBytes();
    // return pickedImages = uploadfile;

    // return fileResult;
  }

  Future<String> uploadImage() async {
    Reference ref = firebaseStorage.ref().child('profile').child(imagepath!);

    UploadTask uploadTask = ref.putData(
      pickedImages!,
     SettableMetadata(contentType: 'image/jpeg'),
    );

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  addEmployees(
      {required int phoneNummber,
      required String name,
      required int salary,
      String? description,
      String? profileUrl}) async {
    try {
      model.Employee employee = model.Employee(
          name: name,
          salary: salary,
          phoneNumber: phoneNummber,
          description: description,
          profilePic: profileUrl ?? '');

      await fireStore.collection("Employees").doc("Employees").update({
        "employees": FieldValue.arrayUnion([employee.toMap()])
      });
    } catch (e) {
      Get.snackbar("adding employee error", e.toString());
    }
  }

  Future<Employees> getEmployees() async {
    var employee = await fireStore
        .collection("Employees")
        .doc("Employees")
        .get()
        .then((value) => value.data() as Map<String, dynamic>);

    Employees employees = Employees.fromMap(employee);
    return employees;
  }

  Future<int> employeelength() async {
    int em = await getEmployees().then((value) => value.employees.length);
    print(em);
    return em;
  }

  deleteEmployee(Employee employee) async {
    await fireStore.collection("Employees").doc("Employees").update({
      "employees": FieldValue.arrayRemove([employee.toMap()])
    });
  }
}
