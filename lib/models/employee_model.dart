import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  String? id;
  final String? name;
  final String? dob;
  final String? gender;

  final String? image;

  Employee({this.id, this.name, this.gender, this.dob, this.image});

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'gender': gender, 'dob': dob, 'image': image};

  static Employee fromJson(Map<String, dynamic> json) => Employee(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      dob: (json['dob'] as Timestamp).toDate().toString(),
      image: json['image']);
}
