import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class StorageService with ListenableServiceMixin {
  static const String _authTokenKey = 'auth_token';
  static const String _userDataKey = 'user_data';

  late SharedPreferences _prefs;
  bool _initialized = false;

  StorageService() {
    _init();
  }

  Future<void> _init() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  Future<void> setAuthToken(String token) async {
    await _init();
    await _prefs.setString(_authTokenKey, token);
    notifyListeners();
  }

  Future<String?> getAuthToken() async {
    await _init();
    return _prefs.getString(_authTokenKey);
  }

  Future<void> removeAuthToken() async {
    await _init();
    await _prefs.remove(_authTokenKey);
    notifyListeners();
  }

  Future<void> setUserData(String userData) async {
    await _init();
    await _prefs.setString(_userDataKey, userData);
    notifyListeners();
  }

  Future<String?> getUserData() async {
    await _init();
    return _prefs.getString(_userDataKey);
  }

  Future<void> removeUserData() async {
    await _init();
    await _prefs.remove(_userDataKey);
    notifyListeners();
  }

  Future<void> clearAll() async {
    await _init();
    await _prefs.clear();
    notifyListeners();
  }
}