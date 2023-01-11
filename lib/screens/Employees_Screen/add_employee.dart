import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wage_management/constants.dart';
import 'package:wage_management/widgets/textformfield.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<Uint8List?>? img;
  String? url;

  

  @override
  Widget build(BuildContext context) {
    // var image = addEmployeeController.pickImage();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 100.h,
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Back',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (img != null) {
                        url = await addEmployeeController.uploadImage();
                      }

                      if (_formKey.currentState!.validate()) {
                        addEmployeeController.addEmployees(
                            name: nameController.text,
                            phoneNummber: int.parse(phoneController.text),
                            salary: int.parse(rateController.text),
                            description: descriptionController.text,
                            profileUrl: url ?? '');
                        nameController.clear();
                        rateController.clear();
                        phoneController.clear();
                        descriptionController.clear();
                      }

                      Navigator.pop(context);                    
                    },
                    child: const Text(
                      'Save',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(
                  () {
                    img = addEmployeeController.pickImage();
                  },
                );
              },
              child: Container(
                height: 150.h,
                width: 150.w,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: FutureBuilder(
                    future: img,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return Image.memory(snapshot.data!);
                      }
                      return Container();
                    })),
              ),
            ),
             SizedBox(
              height: 25.h,
            ),
            Container(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: LabelTextInputField(
                validate: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]').hasMatch(value)) {
                    return 'Enter Correct Name';
                  }
                  return null;
                },
                controller: nameController,
                textInputType: TextInputType.name,
                labelText: 'Name',
              ),
            ),
             SizedBox(
              height: 10.h,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: LabelTextInputField(
                      validate: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[0-9]').hasMatch(value)) {
                          return 'Enter Number';
                        }
                        return null;
                      },
                      controller: rateController,
                      textInputType: TextInputType.number,
                      labelText: 'Rate',
                    ),
                  ),
                   SizedBox(
                    width: 10.w,
                  ),
                  Flexible(
                    child: LabelTextInputField(
                      validate: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[0-9]').hasMatch(value)) {
                          return 'Enter Number';
                        }
                        return null;
                      },
                      controller: phoneController,
                      textInputType: TextInputType.number,
                      labelText: 'Phone Number',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 20.w),
              child: Align(
                  heightFactor: 2,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Discription',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )),
            ),
            Container(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: TextInputField(
                validate: (value) {
                  // if (value!.isEmpty || !RegExp(r'^[0-9]').hasMatch(value)) {
                  //   return 'Enter Number';
                  // }
                  // return null;
                },
                minLines: 5,
                controller: descriptionController,
                textInputType: TextInputType.number,
                labelText: 'Description',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
