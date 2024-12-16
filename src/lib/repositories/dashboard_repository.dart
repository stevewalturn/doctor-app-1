import 'package:injectable/injectable.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/consultation.dart';
import 'package:my_app/models/patient.dart'; 
import 'package:my_app/services/api_service.dart';

@lazySingleton
class DashboardRepository {
  final _apiService = locator<ApiService>();

  DashboardRepository();

  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      return await _apiService.get('/dashboard/stats');
    } catch (e) {
      throw _handleDashboardError(e);
    }
  }

  Future<List<Consultation>> getRecentConsultations() async {
    try {
      final response = await _apiService.get('/consultations/recent');
      return (response['consultations'] as List)
          .map((json) => Consultation.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleDashboardError(e);
    }
  }

  Future<List<Patient>> getRecentPatients() async {
    try {
      final response = await _apiService.get('/patients/recent');
      return (response['patients'] as List)
          .map((json) => Patient.fromJson(json))
          .toList();
    } catch (e) {
      throw _handleDashboardError(e);
    }
  }

  String _handleDashboardError(dynamic error) {
    if (error is Exception) {
      return 'An error occurred while loading dashboard data';
    }
    return error.toString();
  }
}