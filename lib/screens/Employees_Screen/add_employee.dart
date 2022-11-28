import 'package:flutter/material.dart';
import 'package:wage_management/constants.dart';

import 'package:wage_management/widgets/TextFormField.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                validate: (value ) {
                 if (value!.isEmpty || !RegExp(r'^[a-z A-Z]').hasMatch(value)) {
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
                labelText: 'Rate',
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: 150,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    )),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back'),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
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
                    child: const Text('Save'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
