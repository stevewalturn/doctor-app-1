import 'package:my_app/models/consultation.dart';
import 'package:my_app/models/diagnosis.dart';
import 'package:my_app/services/api_service.dart';

class ConsultationRepository {
  final ApiService _apiService;

  ConsultationRepository(this._apiService);

  Future<List<Consultation>> getConsultations() async {
    try {
      final response = await _apiService.get('/consultations');
      return (response['consultations'] as List)
          .map((json) => Consultation.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleConsultationError(e);
    }
  }

  Future<Consultation> getConsultationById(String id) async {
    try {
      final response = await _apiService.get('/consultations/$id');
      return Consultation.fromJson(response);
    } catch (e) {
      throw _handleConsultationError(e);
    }
  }

  Future<Consultation> createConsultation(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.post('/consultations', data);
      return Consultation.fromJson(response);
    } catch (e) {
      throw _handleConsultationError(e);
    }
  }

  Future<Consultation> updateConsultation(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiService.put('/consultations/$id', data);
      return Consultation.fromJson(response);
    } catch (e) {
      throw _handleConsultationError(e);
    }
  }

  Future<Diagnosis> addDiagnosis(
    String consultationId,
    Map<String, dynamic> diagnosisData,
  ) async {
    try {
      final response = await _apiService.post(
        '/consultations/$consultationId/diagnoses',
        diagnosisData,
      );
      return Diagnosis.fromJson(response);
    } catch (e) {
      throw _handleConsultationError(e);
    }
  }

  Future<void> deleteConsultation(String id) async {
    try {
      await _apiService.delete('/consultations/$id');
    } catch (e) {
      throw _handleConsultationError(e);
    }
  }

  String _handleConsultationError(dynamic error) {
    if (error is HttpException) {
      switch (error.statusCode) {
        case 400:
          return 'Invalid consultation data provided. Please check your input.';
        case 401:
          return 'Your session has expired. Please login again.';
        case 403:
          return 'You do not have permission to perform this action.';
        case 404:
          return 'Consultation record not found.';
        case 409:
          return 'A consultation record with this information already exists.';
        case 422:
          return 'Invalid consultation details provided. Please check all required fields.';
        default:
          return 'Failed to process consultation data. Please try again.';
      }
    }
    return 'Unable to connect to the server. Please check your internet connection.';
  }
}
