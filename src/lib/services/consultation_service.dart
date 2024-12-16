import 'package:stacked/stacked.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/consultation.dart';
import 'package:my_app/models/diagnosis.dart';
import 'package:my_app/repositories/consultation_repository.dart';

class ConsultationService with ListenableServiceMixin {
  final _repository = locator<ConsultationRepository>();

  Future<List<Consultation>> getConsultations() async {
    return await _repository.getConsultations();
  }

  Future<Consultation> getConsultationById(String id) async {
    return await _repository.getConsultationById(id);
  }

  Future<Consultation> createConsultation({
    required String patientId,
    required String chiefComplaint, 
    required List<String> symptoms,
    required String notes,
    DateTime? followUpDate,
  }) async {
    final data = {
      'patientId': patientId,
      'chiefComplaint': chiefComplaint,
      'symptoms': symptoms,
      'notes': notes,
      if (followUpDate != null) 'followUpDate': followUpDate.toIso8601String(),
    };

    return await _repository.createConsultation(data);
  }

  Future<Diagnosis> addDiagnosis({
    required String consultationId,
    required String condition,
    required String description,
    required List<String> symptoms,
    required List<String> treatments,
    required List<String> medications,
    required String notes,
  }) async {
    final data = {
      'condition': condition,
      'description': description,
      'symptoms': symptoms,
      'treatments': treatments,
      'medications': medications,
      'notes': notes,
    };

    return await _repository.addDiagnosis(consultationId, data);
  }

  Future<void> deleteConsultation(String id) async {
    await _repository.deleteConsultation(id);
  }
}