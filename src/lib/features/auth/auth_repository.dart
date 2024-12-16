import 'package:my_app/models/user.dart';
import 'package:my_app/services/api_service.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _apiService.post('/auth/login', {
        'email': email,
        'password': password,
      });
      return response;
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
      final response = await _apiService.post('/auth/register', {
        'name': name,
        'email': email,
        'password': password,
        'specialization': specialization,
        'role': 'doctor',
      });
      return response;
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final response = await _apiService.get('/auth/me');
      return User.fromJson(response);
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.post('/auth/logout', {});
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> requestPasswordReset(String email) async {
    try {
      await _apiService.post('/auth/reset-password', {'email': email});
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  String _handleAuthError(dynamic error) {
    if (error is HttpException) {
      switch (error.statusCode) {
        case 400:
          return 'Invalid request. Please check your input and try again.';
        case 401:
          return 'Invalid credentials. Please check your email and password.';
        case 403:
          return 'You do not have permission to perform this action.';
        case 404:
          return 'Account not found. Please check your email or register.';
        case 409:
          return 'An account with this email already exists.';
        case 422:
          return 'Please check your input and try again.';
        case 429:
          return 'Too many attempts. Please try again later.';
        default:
          return 'An error occurred during authentication. Please try again.';
      }
    }
    return 'Unable to connect to the server. Please check your internet connection.';
  }
}
