import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wage_management/models/employee.dart' as model;
import '../constants.dart';
import '../models/employee.dart';

class AddEmployeeController extends GetxController {
  static AddEmployeeController instance = Get.find();

  late Uint8List? pickedImages;
  late File? pickimage;

  // get profilePhoto => _pickedImage;

  Future<Uint8List> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    
    if (pickedImage != null) {
      Get.snackbar('Profile Picture', "Picture selected");
    }

    var uploadfile = pickedImage!.readAsBytes();
    return pickedImages = await uploadfile;
  }

  // upload firebase Storage
  // Future<String> _uploadToStorage(Uint8List image) async {
  // UploadTask uploadTask = ref.putData(image);
  // TaskSnapshot snap = await uploadTask;
  // String downloadUrl = await snap.ref.getDownloadURL();

  //return downloadUrl;

  addEmployees(int id, String name, int salary) async {
    try {
      model.Employee employee =
          model.Employee(id: id, name: name, salary: salary);
      // model.Employees employees = model.Employees(employees: [employee]);
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
}

// UPLOAD to firebase Storage

 

