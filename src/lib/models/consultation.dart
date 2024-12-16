import 'package:equatable/equatable.dart';
import 'package:my_app/models/diagnosis.dart';

class Consultation extends Equatable {
  final String id;
  final String patientId;
  final String doctorId;
  final DateTime consultationDate;
  final String chiefComplaint;
  final List<String> symptoms;
  final String? notes;
  final List<Diagnosis> diagnoses;
  final String status;
  final DateTime? followUpDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Consultation({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.consultationDate,
    required this.chiefComplaint,
    required this.symptoms,
    this.notes,
    required this.diagnoses,
    required this.status,
    this.followUpDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      consultationDate: DateTime.parse(json['consultationDate'] as String),
      chiefComplaint: json['chiefComplaint'] as String,
      symptoms: List<String>.from(json['symptoms'] as List),
      notes: json['notes'] as String?,
      diagnoses: (json['diagnoses'] as List)
          .map((e) => Diagnosis.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      followUpDate: json['followUpDate'] != null
          ? DateTime.parse(json['followUpDate'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'consultationDate': consultationDate.toIso8601String(),
      'chiefComplaint': chiefComplaint,
      'symptoms': symptoms,
      'notes': notes,
      'diagnoses': diagnoses.map((d) => d.toJson()).toList(),
      'status': status,
      'followUpDate': followUpDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Consultation copyWith({
    String? id,
    String? patientId,
    String? doctorId,
    DateTime? consultationDate,
    String? chiefComplaint,
    List<String>? symptoms,
    String? notes,
    List<Diagnosis>? diagnoses,
    String? status,
    DateTime? followUpDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Consultation(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      doctorId: doctorId ?? this.doctorId,
      consultationDate: consultationDate ?? this.consultationDate,
      chiefComplaint: chiefComplaint ?? this.chiefComplaint,
      symptoms: symptoms ?? this.symptoms,
      notes: notes ?? this.notes,
      diagnoses: diagnoses ?? this.diagnoses,
      status: status ?? this.status,
      followUpDate: followUpDate ?? this.followUpDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        patientId,
        doctorId,
        consultationDate,
        chiefComplaint,
        symptoms,
        notes,
        diagnoses,
        status,
        followUpDate,
        createdAt,
        updatedAt,
      ];
}
