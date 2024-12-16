import 'package:stacked/stacked.dart';
import 'package:my_app/models/consultation.dart';
import 'package:my_app/models/diagnosis.dart';
import 'package:my_app/features/consultation/consultation_repository.dart';

class ConsultationService with InitializableDependency {
  final ConsultationRepository _repository;

  ConsultationService(this._repository);

  Future<List<Consultation>> getConsultations() async {
    try {
      return await _repository.getConsultations();
    } catch (e) {
      throw _formatError(e);
    }
  }

  Future<Consultation> getConsultationById(String id) async {
    try {
      return await _repository.getConsultationById(id);
    } catch (e) {
      throw _formatError(e);
    }
  }

  Future<Consultation> createConsultation({
    required String patientId,
    required String chiefComplaint,
    required List<String> symptoms,
    required String notes,
    DateTime? followUpDate,
  }) async {
    try {
      final consultationData = {
        'patientId': patientId,
        'chiefComplaint': chiefComplaint,
        'symptoms': symptoms,
        'notes': notes,
        'status': 'active',
        'followUpDate': followUpDate?.toIso8601String(),
      };
      return await _repository.createConsultation(consultationData);
    } catch (e) {
      throw _formatError(e);
    }
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
    try {
      final diagnosisData = {
        'condition': condition,
        'description': description,
        'symptoms': symptoms,
        'treatments': treatments,
        'medications': medications,
        'notes': notes,
      };
      return await _repository.addDiagnosis(consultationId, diagnosisData);
    } catch (e) {
      throw _formatError(e);
    }
  }

  Future<void> deleteConsultation(String id) async {
    try {
      await _repository.deleteConsultation(id);
    } catch (e) {
      throw _formatError(e);
    }
  }

  String _formatError(dynamic error) {
    if (error is String) {
      return error;
    }
    return 'An unexpected error occurred while processing your request.';
  }

  @override
  Future<void> init() async {
    // Initialize any required resources
  }
}
