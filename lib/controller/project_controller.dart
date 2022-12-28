import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wage_management/constants.dart';
import 'package:wage_management/models/project.dart';

class ProjectController extends GetxController {
  static ProjectController instance = Get.put(ProjectController());

  addProjects(String name) {
    try {
      Project project = Project(name: name);

      fireStore.collection('projects').doc('projects').update({
        'projects': FieldValue.arrayUnion([project.toMap()])
      });
    } catch (e) {
      e.toString();
    }
  }

  Future<Projects> getProjects() async {
    var projects = await fireStore
        .collection('projects')
        .doc('projects')
        .get()
        .then((value) => value.data());

    return Projects.fromMap(projects ?? {});
  }

  deleteproject(Project project) async {
    await fireStore.collection('projects').doc('projects').update({
      'projects': FieldValue.arrayRemove([project.toMap()])
    });
  }
}
