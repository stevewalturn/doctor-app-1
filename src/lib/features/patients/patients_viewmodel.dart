import 'package:stacked/stacked.dart';
import 'package:my_app/models/patient.dart';
import 'package:my_app/features/patients/patients_repository.dart';
import 'package:my_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class PatientsViewModel extends BaseViewModel {
  final PatientsRepository _repository;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  PatientsViewModel(
    this._repository,
    this._navigationService,
    this._dialogService,
  );

  List<Patient> _patients = [];
  String? _searchQuery;
  String? _modelError;

  List<Patient> get patients => _patients;
  String? get searchQuery => _searchQuery;
  String? get modelError => _modelError;

  List<Patient> get filteredPatients {
    if (_searchQuery == null || _searchQuery!.isEmpty) {
      return _patients;
    }
    return _patients.where((patient) {
      return patient.name.toLowerCase().contains(_searchQuery!.toLowerCase()) ||
          patient.contactNumber.contains(_searchQuery!);
    }).toList();
  }

  Future<void> initialize() async {
    await loadPatients();
  }

  Future<void> loadPatients() async {
    try {
      setBusy(true);
      _patients = await _repository.getPatients();
      notifyListeners();
    } catch (e) {
      _modelError = e.toString();
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> navigateToAddPatient() async {
    final result = await _navigationService.navigateTo(Routes.addPatientView);
    if (result == true) {
      await loadPatients();
    }
  }

  Future<void> navigateToPatientDetails(Patient patient) async {
    await _navigationService.navigateTo(
      Routes.patientDetailsView,
      arguments: patient,
    );
  }

  Future<void> deletePatient(Patient patient) async {
    final response = await _dialogService.showConfirmationDialog(
      title: 'Delete Patient',
      description: 'Are you sure you want to delete ${patient.name}?',
      confirmationTitle: 'Delete',
      cancelTitle: 'Cancel',
    );

    if (response?.confirmed ?? false) {
      try {
        setBusy(true);
        await _repository.deletePatient(patient.id);
        await loadPatients();
        _dialogService.showDialog(
          title: 'Success',
          description: 'Patient deleted successfully',
        );
      } catch (e) {
        _modelError = e.toString();
        notifyListeners();
        _dialogService.showDialog(
          title: 'Error',
          description: e.toString(),
        );
      } finally {
        setBusy(false);
      }
    }
  }
}
