import 'package:my_app/models/consultation.dart';
import 'package:my_app/models/patient.dart';
import 'package:my_app/services/api_service.dart';

class DashboardRepository {
  final ApiService _apiService;

  DashboardRepository(this._apiService);

  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final response = await _apiService.get('/dashboard/stats');
      return response;
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
    if (error is HttpException) {
      switch (error.statusCode) {
        case 401:
          return 'Your session has expired. Please login again.';
        case 403:
          return 'You do not have permission to access this data.';
        case 404:
          return 'Dashboard data not found.';
        default:
          return 'Failed to load dashboard data. Please try again.';
      }
    }
    return 'Unable to connect to the server. Please check your internet connection.';
  }
}
