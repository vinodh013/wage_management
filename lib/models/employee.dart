import 'dart:convert';

import 'package:flutter/foundation.dart';

class Employee {
  String? profilePic;
  String name;
  int salary;
  int phoneNumber;
  String? description;

  Employee({
    this.profilePic,
    required this.name,
    required this.salary,
    required this.phoneNumber,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'profilePic': profilePic,
      'name': name,
      'salary': salary,
      'phoneNumber': phoneNumber,
      'description': description,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      profilePic: map['profilePic'],
      name: map['name'] ?? '',
      salary: map['salary']?.toInt() ?? 0,
      phoneNumber: map['phoneNumber']?.toInt() ?? 0,
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source));

  Employee copyWith({
    String? profilePic,
    String? name,
    int? salary,
    int? phoneNumber,
    String? description,
  }) {
    return Employee(
      profilePic: profilePic ?? this.profilePic,
      name: name ?? this.name,
      salary: salary ?? this.salary,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'Employee(profilePic: $profilePic, name: $name, salary: $salary, phoneNumber: $phoneNumber, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Employee &&
      other.profilePic == profilePic &&
      other.name == name &&
      other.salary == salary &&
      other.phoneNumber == phoneNumber &&
      other.description == description;
  }

  @override
  int get hashCode {
    return profilePic.hashCode ^
      name.hashCode ^
      salary.hashCode ^
      phoneNumber.hashCode ^
      description.hashCode;
  }
}

class Employees {
  List<Employee> employees;
  Employees({
    required this.employees,
  });

  Map<String, dynamic> toMap() {
    return {
      'employees': employees.map((x) => x.toMap()).toList(),
    };
  }

  factory Employees.fromMap(Map<String, dynamic> map) {
    return Employees(
      employees: List<Employee>.from(
          map['employees']?.map((x) => Employee.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Employees.fromJson(String source) =>
      Employees.fromMap(json.decode(source));
}
