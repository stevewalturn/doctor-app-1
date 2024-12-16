import 'package:injectable/injectable.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/patient.dart';
import 'package:my_app/services/api_service.dart';

@lazySingleton
class PatientsRepository {
  final _apiService = locator<ApiService>();

  PatientsRepository();

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

  Future<void> deletePatient(String id) async {
    try {
      await _apiService.delete('/patients/$id');
    } catch (e) {
      throw _handlePatientError(e);
    }
  }

  String _handlePatientError(dynamic error) {
    if (error is Exception) {
      return 'An error occurred while processing patient data';
    }
    return error.toString();
  }
}