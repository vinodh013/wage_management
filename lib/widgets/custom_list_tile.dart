import 'package:flutter/material.dart';

import 'package:wage_management/controller/project_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      padding:
          EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
      height: 90.h,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          date == null ? Text('') : Text(date!),
          Text(projectname),
          IconButton(onPressed: onPressed, icon: const Icon(Icons.delete), padding: EdgeInsets.all(0),)
        ],
      ),
    );
  }
}

class ProjectCustomListTile extends StatelessWidget {
  String projectname;
  ProjectController getProjectController;
  //BuildContext context;
  void Function()? onpress;

  ProjectCustomListTile(
      {Key? key,
      required this.projectname,
      required this.getProjectController,
      required this.onpress
      // required this.context,
      })
      : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = projectname;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
      padding:
          EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
      height: 90.h,
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
                        padding: EdgeInsets.only(
                            left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r)),
                        height: 220.h,
                        width: 230.w,
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
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 251, 241, 241),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.w),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                      onPressed: onpress,
                                      child: const Text('Delete')),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                     
                                      onPressed: () async {
                                        await getProjectController
                                            .addProjects(controller.text);

                                        controller.clear();
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
              style:  ButtonStyle(
                padding:   MaterialStateProperty.all(const EdgeInsets.all(0)) 
              ),
              child: const Text('Edit'))
        ],
      ),
    );
  }
}
