import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  final String id;
  final String name;
  final String gender;
  final DateTime dateOfBirth;
  final String contactNumber;
  final String? email;
  final String address;
  final String? bloodGroup;
  final List<String> allergies;
  final List<String> chronicConditions;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Patient({
    required this.id,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.contactNumber,
    this.email,
    required this.address,
    this.bloodGroup,
    this.allergies = const [],
    this.chronicConditions = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  int get age {
    return DateTime.now().difference(dateOfBirth).inDays ~/ 365;
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      contactNumber: json['contactNumber'] as String,
      email: json['email'] as String?,
      address: json['address'] as String,
      bloodGroup: json['bloodGroup'] as String?,
      allergies: List<String>.from(json['allergies'] as List),
      chronicConditions: List<String>.from(json['chronicConditions'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'contactNumber': contactNumber,
      'email': email,
      'address': address,
      'bloodGroup': bloodGroup,
      'allergies': allergies,
      'chronicConditions': chronicConditions,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Patient copyWith({
    String? id,
    String? name,
    String? gender,
    DateTime? dateOfBirth,
    String? contactNumber,
    String? email,
    String? address,
    String? bloodGroup,
    List<String>? allergies,
    List<String>? chronicConditions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      allergies: allergies ?? this.allergies,
      chronicConditions: chronicConditions ?? this.chronicConditions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        gender,
        dateOfBirth,
        contactNumber,
        email,
        address,
        bloodGroup,
        allergies,
        chronicConditions,
        createdAt,
        updatedAt,
      ];
}
