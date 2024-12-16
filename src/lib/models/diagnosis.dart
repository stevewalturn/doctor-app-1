import 'package:equatable/equatable.dart';

class Diagnosis extends Equatable {
  final String id;
  final String consultationId;
  final String condition;
  final String description;
  final List<String> symptoms;
  final List<String> treatments;
  final List<String> medications;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Diagnosis({
    required this.id,
    required this.consultationId,
    required this.condition,
    required this.description,
    required this.symptoms,
    required this.treatments,
    required this.medications,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      id: json['id'] as String,
      consultationId: json['consultationId'] as String,
      condition: json['condition'] as String,
      description: json['description'] as String,
      symptoms: List<String>.from(json['symptoms'] as List),
      treatments: List<String>.from(json['treatments'] as List),
      medications: List<String>.from(json['medications'] as List),
      notes: json['notes'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'consultationId': consultationId,
      'condition': condition,
      'description': description,
      'symptoms': symptoms,
      'treatments': treatments,
      'medications': medications,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Diagnosis copyWith({
    String? id,
    String? consultationId,
    String? condition,
    String? description,
    List<String>? symptoms,
    List<String>? treatments,
    List<String>? medications,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Diagnosis(
      id: id ?? this.id,
      consultationId: consultationId ?? this.consultationId,
      condition: condition ?? this.condition,
      description: description ?? this.description,
      symptoms: symptoms ?? this.symptoms,
      treatments: treatments ?? this.treatments,
      medications: medications ?? this.medications,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        consultationId,
        condition,
        description,
        symptoms,
        treatments,
        medications,
        notes,
        createdAt,
        updatedAt,
      ];
}
