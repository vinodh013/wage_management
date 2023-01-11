import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wage_management/controller/project_controller.dart';
import 'package:wage_management/models/project.dart';
import 'package:wage_management/widgets/custom_list_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    var getProjectcontroller = Get.put(ProjectController());
    TextEditingController projectController = TextEditingController();
    // var mediaheight = MediaQuery.of(context).size.height;
    // var mediawidth = MediaQuery.of(context).size.width;
    // print(mediaheight);
    // print(mediawidth);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          child: Column(
            children: [
              Container(
                height: 80.h,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              // shape: CircleBorder(side: BorderSide( )),
                              child: Container(
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.r)),
                                height: 200.h,
                                width: 200.w,
                                child: Column(
                                  children: [
                                     SizedBox(
                                      height: 15.h,
                                    ),
                                    Text(
                                      'Add Project',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                     SizedBox(
                                      height: 25.h,
                                    ),
                                    TextFormField(
                                      controller: projectController,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 251, 241, 241),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1),
                                        ),
                                      ),
                                    ),
                                     SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                          onPressed: () {
                                            getProjectcontroller.addProjects(
                                                projectController.text);

                                            projectController.clear();

                                            Navigator.pop(context);
                                          },
                                          child: const Text('Save')),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                        setState(() {});
                      },
                      child: const Text(
                        'Add Project',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
              FutureBuilder(
                future: getProjectcontroller.getProjects(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.projects.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10.w),
                          child: ProjectCustomListTile(
                            //  context: context,
                            getProjectController: getProjectcontroller,
                            projectname: snapshot.data!.projects[index].name,
                            onpress: () async {
                              await getProjectcontroller.deleteproject(Project(
                                  name: snapshot.data!.projects[index].name));

                              setState(() {});
                              navigator!.pop(context);
                            },
                          ),
                        );
                      },
                    );
                  } else {}

                  return Text('Slow Internet');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
