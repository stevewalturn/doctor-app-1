import 'package:stacked/stacked.dart';
import 'package:my_app/services/authentication_service.dart';
import 'package:my_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthViewModel extends BaseViewModel {
  final AuthenticationService _authService;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  AuthViewModel(
    this._authService,
    this._navigationService,
    this._dialogService,
  );

  String _email = '';
  String _password = '';
  String _name = '';
  String _specialization = '';
  String? _modelError;

  String get email => _email;
  String get password => _password;
  String get name => _name;
  String get specialization => _specialization;
  String? get modelError => _modelError;

  void setEmail(String value) {
    _email = value;
    _modelError = null;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    _modelError = null;
    notifyListeners();
  }

  void setName(String value) {
    _name = value;
    _modelError = null;
    notifyListeners();
  }

  void setSpecialization(String value) {
    _specialization = value;
    _modelError = null;
    notifyListeners();
  }

  bool _validateLoginInput() {
    if (_email.isEmpty || _password.isEmpty) {
      _modelError = 'Please fill in all fields';
      notifyListeners();
      return false;
    }
    if (!_email.contains('@')) {
      _modelError = 'Please enter a valid email address';
      notifyListeners();
      return false;
    }
    return true;
  }

  bool _validateRegistrationInput() {
    if (_email.isEmpty ||
        _password.isEmpty ||
        _name.isEmpty ||
        _specialization.isEmpty) {
      _modelError = 'Please fill in all fields';
      notifyListeners();
      return false;
    }
    if (!_email.contains('@')) {
      _modelError = 'Please enter a valid email address';
      notifyListeners();
      return false;
    }
    if (_password.length < 8) {
      _modelError = 'Password must be at least 8 characters long';
      notifyListeners();
      return false;
    }
    return true;
  }

  Future<void> login() async {
    if (!_validateLoginInput()) return;

    try {
      setBusy(true);
      await _authService.login(_email, _password);
      await _navigationService.clearStackAndShow(Routes.dashboardView);
    } catch (e) {
      _modelError = e.toString();
      notifyListeners();
      await _dialogService.showDialog(
        title: 'Login Failed',
        description: e.toString(),
      );
    } finally {
      setBusy(false);
    }
  }

  Future<void> register() async {
    if (!_validateRegistrationInput()) return;

    try {
      setBusy(true);
      await _authService.register(
        name: _name,
        email: _email,
        password: _password,
        specialization: _specialization,
      );
      await _navigationService.clearStackAndShow(Routes.dashboardView);
    } catch (e) {
      _modelError = e.toString();
      notifyListeners();
      await _dialogService.showDialog(
        title: 'Registration Failed',
        description: e.toString(),
      );
    } finally {
      setBusy(false);
    }
  }

  Future<void> logout() async {
    try {
      setBusy(true);
      await _authService.logout();
      await _navigationService.clearStackAndShow(Routes.loginView);
    } catch (e) {
      _modelError = e.toString();
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  void navigateToRegister() {
    _navigationService.navigateTo(Routes.registerView);
  }

  void navigateToLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }
}
