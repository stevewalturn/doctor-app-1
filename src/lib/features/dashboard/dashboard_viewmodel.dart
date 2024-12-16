import 'package:stacked/stacked.dart';
import 'package:my_app/models/consultation.dart';
import 'package:my_app/models/patient.dart';
import 'package:my_app/features/dashboard/dashboard_repository.dart';

class DashboardViewModel extends BaseViewModel {
  final DashboardRepository _repository;

  DashboardViewModel(this._repository);

  int _totalPatients = 0;
  int _totalConsultations = 0;
  int _pendingConsultations = 0;
  List<Consultation> _recentConsultations = [];
  List<Patient> _recentPatients = [];
  String? _modelError;

  int get totalPatients => _totalPatients;
  int get totalConsultations => _totalConsultations;
  int get pendingConsultations => _pendingConsultations;
  List<Consultation> get recentConsultations => _recentConsultations;
  List<Patient> get recentPatients => _recentPatients;
  String? get modelError => _modelError;

  Future<void> initialize() async {
    await Future.wait([
      loadDashboardStats(),
      loadRecentConsultations(),
      loadRecentPatients(),
    ]);
  }

  Future<void> loadDashboardStats() async {
    try {
      setBusy(true);
      final stats = await _repository.getDashboardStats();
      _totalPatients = stats['totalPatients'] as int;
      _totalConsultations = stats['totalConsultations'] as int;
      _pendingConsultations = stats['pendingConsultations'] as int;
      notifyListeners();
    } catch (e) {
      _modelError = e.toString();
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  Future<void> loadRecentConsultations() async {
    try {
      _recentConsultations = await _repository.getRecentConsultations();
      notifyListeners();
    } catch (e) {
      _modelError = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadRecentPatients() async {
    try {
      _recentPatients = await _repository.getRecentPatients();
      notifyListeners();
    } catch (e) {
      _modelError = e.toString();
      notifyListeners();
    }
  }

  Future<void> refreshDashboard() async {
    await initialize();
  }
}
