import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wage_management/constants.dart';
import 'package:wage_management/controller/add_employee_controller.dart';

import 'package:wage_management/widgets/TextFormField.dart';

class AddEmployee extends StatefulWidget {
  AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   Future<Uint8List>? img;

  @override
  Widget build(BuildContext context) {
    // var image = addEmployeeController.pickImage();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 60,
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addEmployeeController.addEmployees(
                          3,
                          nameController.text,
                          int.parse(rateController.text),
                        );
                        nameController.clear();
                        rateController.clear();
                      }
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
                  ()  {
                      img =  addEmployeeController.pickImage();
                  },
                );
              },
              child: Container(
                height: 150,
                width: 150,
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
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextInputField(
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
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextInputField(
                      validate: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[0-9]').hasMatch(value)) {
                          return 'Enter Number';
                        }
                        return null;
                      },
                      controller: rateController,
                      textInputType: TextInputType.number,
                      labelText: 'Phone Number',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                validate: (value) {
                  if (value!.isEmpty || !RegExp(r'^[0-9]').hasMatch(value)) {
                    return 'Enter Number';
                  }
                  return null;
                },
                controller: rateController,
                textInputType: TextInputType.number,
                labelText: 'Phone Number',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
