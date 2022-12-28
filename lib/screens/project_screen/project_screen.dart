import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wage_management/controller/project_controller.dart';
import 'package:wage_management/widgets/custom_list_tile.dart';

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

    // GlobalKey<NavigatorState> d = GlobalKey();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              Container(
                height: 80,
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
                              padding: EdgeInsets.all(10),
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
                                  const SizedBox(
                                    height: 10,
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

                      setState(() {
                        
                      });
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ProjectCustomListTile(
                            //  context: context,
                              getProjectController: getProjectcontroller,
                              projectname: snapshot.data!.projects[index].name),
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
