import 'package:shared_preferences.dart';
import 'package:stacked/stacked.dart';

class StorageService with InitializableDependency {
  static const String _authTokenKey = 'auth_token';
  static const String _userDataKey = 'user_data';

  late SharedPreferences _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setAuthToken(String token) async {
    await _prefs.setString(_authTokenKey, token);
  }

  Future<String?> getAuthToken() async {
    return _prefs.getString(_authTokenKey);
  }

  Future<void> removeAuthToken() async {
    await _prefs.remove(_authTokenKey);
  }

  Future<void> setUserData(String userData) async {
    await _prefs.setString(_userDataKey, userData);
  }

  Future<String?> getUserData() async {
    return _prefs.getString(_userDataKey);
  }

  Future<void> removeUserData() async {
    await _prefs.remove(_userDataKey);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
