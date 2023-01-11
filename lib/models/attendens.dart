import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Attendents {

  
  String name;
  String date;
  String project;
  String timeIn;
  String timeOut;
  int overTime;
  Attendents({
    required this.name,
    required this.date,
    required this.project,
    required this.timeIn,
    required this.timeOut,
    required this.overTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'project': project,
      'timeIn': timeIn,
      'timeOut': timeOut,
      'overTime': overTime,
    };
  }

  factory Attendents.fromMap(Map<String, dynamic> map) {
    return Attendents(
      name: map['name'] ?? '',
      date: map['date'] ?? '',
      project: map['project'] ?? '',
      timeIn: map['timeIn'] ?? '',
      timeOut: map['timeOut'] ?? '',
      overTime: map['overTime']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendents.fromJson(String source) =>
      Attendents.fromMap(json.decode(source));

  Attendents copyWith({
    String? name,
    String? date,
    String? project,
    String? timeIn,
    String? timeOut,
    int? overTime,
  }) {
    return Attendents(
      name: name ?? this.name,
      date: date ?? this.date,
      project: project ?? this.project,
      timeIn: timeIn ?? this.timeIn,
      timeOut: timeOut ?? this.timeOut,
      overTime: overTime ?? this.overTime,
    );
  }

  @override
  String toString() {
    return 'Attendents(name: $name, date: $date, project: $project, timeIn: $timeIn, timeOut: $timeOut, overTime: $overTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Attendents &&
      other.name == name &&
      other.date == date &&
      other.project == project &&
      other.timeIn == timeIn &&
      other.timeOut == timeOut &&
      other.overTime == overTime;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      date.hashCode ^
      project.hashCode ^
      timeIn.hashCode ^
      timeOut.hashCode ^
      overTime.hashCode;
  }

  void forEach(Null Function(dynamic element) param0) {}
}

class AllAttendents {
  List<Attendents> allAttendents;
  AllAttendents({
    required this.allAttendents,
  });

  AllAttendents copyWith({
    List<Attendents>? allAttendents,
  }) {
    return AllAttendents(
      allAttendents: allAttendents ?? this.allAttendents,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attendece': allAttendents.map((x) => x.toMap()).toList(),
    };
  }

  factory AllAttendents.fromMap(Map<String, dynamic> map) {
    return AllAttendents(
      allAttendents: List<Attendents>.from(
          map['attendece']?.map((x) => Attendents.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AllAttendents.fromJson(String source) =>
      AllAttendents.fromMap(json.decode(source));

  @override
  String toString() => 'AllAttendents(attendece: $allAttendents)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is AllAttendents &&
        listEquals(other.allAttendents, allAttendents);
  }

  @override
  int get hashCode => allAttendents.hashCode;
}
