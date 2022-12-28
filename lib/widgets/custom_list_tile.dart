import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wage_management/controller/project_controller.dart';
import 'package:wage_management/models/project.dart';
import 'package:wage_management/screens/project_screen/project_screen.dart';

class CustomListTile extends StatelessWidget {
  String projectname;
  String? date;
  VoidCallback onPressed;

  CustomListTile({
    Key? key,
    required this.projectname,
    this.date,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(20),
      height: 65,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          date == null ? Text('') : Text(date!),
          Text(projectname),
          IconButton(onPressed: onPressed, icon: const Icon(Icons.delete))
        ],
      ),
    );
  }
}

class ProjectCustomListTile extends StatelessWidget {
  String projectname;
  ProjectController getProjectController;
  //BuildContext context;

  ProjectCustomListTile({
    Key? key,
    required this.projectname,
    required this.getProjectController,
    // required this.context,
  }) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = projectname;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(20),
      height: 65,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            projectname,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      // shape: CircleBorder(side: BorderSide( )),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        height: 200,
                        width: 200,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Add Project',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              controller: controller,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 251, 241, 241),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                      onPressed: () async {
                                        await getProjectController
                                            .deleteproject(
                                                Project(name: projectname));

                                        controller.clear();

                                        navigator!.pop(context);
                                      },
                                      child: const Text('Delete')),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                      onPressed: () async {
                                        await getProjectController
                                            .addProjects(controller.text);

                                        controller.clear();

                                        navigator!.pop(context);
                                      },
                                      child: const Text('Save')),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text('Edit'))
        ],
      ),
    );
  }
}
