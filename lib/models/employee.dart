import 'dart:convert';

class Employee {
  int id;
  String name;
  int salary;
  Employee({
    required this.id,
    required this.name,
    required this.salary,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'salary': salary,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      salary: map['salary']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source));
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
      employees: List<Employee>.from(map['employees']?.map((x) => Employee.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Employees.fromJson(String source) => Employees.fromMap(json.decode(source));
}
