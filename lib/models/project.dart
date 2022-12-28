import 'dart:convert';

import 'package:flutter/foundation.dart';

class Project {
  String name;
  Project({
    required this.name,
  });

  Project copyWith({
    String? name,
  }) {
    return Project(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source));

  @override
  String toString() => 'Project(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Project && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class Projects {
  List<Project> projects;
  Projects({
    required this.projects,
  });

  

  Projects copyWith({
    List<Project>? projects,
  }) {
    return Projects(
      projects: projects ?? this.projects,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'projects': projects.map((x) => x.toMap()).toList(),
    };
  }

  factory Projects.fromMap(Map<String, dynamic> map) {
    return Projects(
      projects: List<Project>.from(map['projects']?.map((x) => Project.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Projects.fromJson(String source) => Projects.fromMap(json.decode(source));

  @override
  String toString() => 'Projects(projects: $projects)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Projects &&
      listEquals(other.projects, projects);
  }

  @override
  int get hashCode => projects.hashCode;
}
