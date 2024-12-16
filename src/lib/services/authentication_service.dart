import 'package:stacked/stacked.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/services/api_service.dart';
import 'package:my_app/services/storage_service.dart';

class AuthenticationService with ListenableServiceMixin {
  final _apiService = locator<ApiService>();
  final _storageService = locator<StorageService>();

  User? _currentUser;
  
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  AuthenticationService() {
    listenToReactiveValues([_currentUser]);
  }

  Future<void> init() async {
    final token = await _storageService.getAuthToken();
    if (token != null) {
      _apiService.setAuthToken(token);
      try {
        final userData = await _apiService.get('/auth/me');
        _currentUser = User.fromJson(userData);
      } catch (e) {
        await logout();
      }
    }
  }

  Future<User> login(String email, String password) async {
    try {
      final response = await _apiService.post('/auth/login', {
        'email': email,
        'password': password,
      });

      final token = response['token'] as String;
      await _storageService.setAuthToken(token);
      _apiService.setAuthToken(token);

      _currentUser = User.fromJson(response['user']);
      return _currentUser!;
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<User> register({
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
      });

      final token = response['token'] as String;
      await _storageService.setAuthToken(token);
      _apiService.setAuthToken(token);

      _currentUser = User.fromJson(response['user']);
      return _currentUser!;
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.post('/auth/logout', {});
    } catch (e) {
      // Ignore logout errors
    } finally {
      await _storageService.removeAuthToken();
      _apiService.removeAuthToken();
      _currentUser = null;
    }
  }

  String _handleAuthError(dynamic error) {
    if (error is Exception) {
      return 'Authentication failed. Please try again.';
    }
    return error.toString();
  }
}