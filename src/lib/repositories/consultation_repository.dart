import 'package:injectable/injectable.dart';
import 'package:my_app/models/consultation.dart';
import 'package:my_app/models/diagnosis.dart';
import 'package:my_app/services/api_service.dart';
import 'package:my_app/app/app.locator.dart';

@lazySingleton
class ConsultationRepository {
  final _apiService = locator<ApiService>();

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

  Future<void> deleteConsultation(String id) async {
    try {
      await _apiService.delete('/consultations/$id');
    } catch (e) {
      throw _handleConsultationError(e);
    }
  }

  String _handleConsultationError(dynamic error) {
    if (error is Exception) {
      return 'An error occurred while processing the consultation';
    }
    return error.toString();
  }
}