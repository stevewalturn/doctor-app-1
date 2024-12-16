import 'package:injectable/injectable.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/api_service.dart';

@lazySingleton
class AuthRepository {
  final _apiService = locator<ApiService>();

  AuthRepository();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      return await _apiService.post('/auth/login', {
        'email': email,
        'password': password,
      });
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String specialization,
  }) async {
    try {
      return await _apiService.post('/auth/register', {
        'name': name,
        'email': email,
        'password': password,
        'specialization': specialization,
      });
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  String _handleAuthError(dynamic error) {
    if (error is Exception) {
      return 'Authentication failed. Please try again.';
    }
    return error.toString();
  }
}