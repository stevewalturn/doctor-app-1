import 'package:my_app/models/patient.dart';
import 'package:my_app/services/api_service.dart';

class PatientsRepository {
  final ApiService _apiService;

  PatientsRepository(this._apiService);

  Future<List<Patient>> getPatients() async {
    try {
      final response = await _apiService.get('/patients');
      return (response['patients'] as List)
          .map((json) => Patient.fromJson(json))
          .toList();
    } catch (e) {
      throw _handlePatientError(e);
    }
  }

  Future<Patient> getPatientById(String id) async {
    try {
      final response = await _apiService.get('/patients/$id');
      return Patient.fromJson(response);
    } catch (e) {
      throw _handlePatientError(e);
    }
  }

  Future<Patient> createPatient(Map<String, dynamic> patientData) async {
    try {
      final response = await _apiService.post('/patients', patientData);
      return Patient.fromJson(response);
    } catch (e) {
      throw _handlePatientError(e);
    }
  }

  Future<Patient> updatePatient(
      String id, Map<String, dynamic> patientData) async {
    try {
      final response = await _apiService.put('/patients/$id', patientData);
      return Patient.fromJson(response);
    } catch (e) {
      throw _handlePatientError(e);
    }
  }

  Future<void> deletePatient(String id) async {
    try {
      await _apiService.delete('/patients/$id');
    } catch (e) {
      throw _handlePatientError(e);
    }
  }

  String _handlePatientError(dynamic error) {
    if (error is HttpException) {
      switch (error.statusCode) {
        case 400:
          return 'Invalid patient data provided. Please check your input.';
        case 401:
          return 'You need to be logged in to manage patients.';
        case 403:
          return 'You do not have permission to perform this action.';
        case 404:
          return 'Patient not found.';
        case 409:
          return 'A patient with this information already exists.';
        default:
          return 'Failed to process patient data. Please try again.';
      }
    }
    return 'Unable to connect to the server. Please check your internet connection.';
  }
}
