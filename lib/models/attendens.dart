import 'dart:convert';

class Attendents {
  String name;
  int noOfHours;
  Attendents({
    required this.name,
    required this.noOfHours,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'noOfHours': noOfHours,
    };
  }

  factory Attendents.fromMap(Map<String, dynamic> map) {
    return Attendents(
      name: map['name'] ?? '',
      noOfHours: map['noOfHours']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendents.fromJson(String source) =>
      Attendents.fromMap(json.decode(source));
}

class TotalAttendents {
  List<Attendents> attendents;
  TotalAttendents({
    required this.attendents,
  });

  Map<String, dynamic> toMap() {
    return {
      'attendents': attendents.map((x) => x.toMap()).toList(),
    };
  }

  factory TotalAttendents.fromMap(Map<String, dynamic> map) {
    return TotalAttendents(
      attendents: List<Attendents>.from(map['attendents']?.map((x) => Attendents.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TotalAttendents.fromJson(String source) => TotalAttendents.fromMap(json.decode(source));
}
