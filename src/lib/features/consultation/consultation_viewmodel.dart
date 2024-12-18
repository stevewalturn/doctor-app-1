import 'package:stacked/stacked.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/consultation.dart';
import 'package:my_app/services/consultation_service.dart';
import 'package:stacked_services/stacked_services.dart';

class ConsultationViewModel extends BaseViewModel {
  final ConsultationService _consultationService;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  ConsultationViewModel(
    this._consultationService,
    this._navigationService,
    this._dialogService,
  );

  List<Consultation> _consultations = [];
  Consultation? _selectedConsultation;
  String? _modelError;

  List<Consultation> get consultations => _consultations;
  Consultation? get selectedConsultation => _selectedConsultation;
  String? get modelError => _modelError;

  Future<void> initialize() async {
    await loadConsultations();
  }

  Future<void> loadConsultations() async {
    try {
      setBusy(true);
      _consultations = await _consultationService.getConsultations();
      notifyListeners();
    } catch (e) {
      _modelError = e.toString();
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  Future<void> selectConsultation(String id) async {
    try {
      setBusy(true);
      _selectedConsultation = await _consultationService.getConsultationById(id);
      notifyListeners();
    } catch (e) {
      _modelError = e.toString();
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  Future<bool> createConsultation({
    required String patientId,
    required String chiefComplaint,
    required List<String> symptoms,
    required String notes,
    DateTime? followUpDate,
  }) async {
    try {
      setBusy(true);
      final consultation = await _consultationService.createConsultation(
        patientId: patientId,
        chiefComplaint: chiefComplaint,
        symptoms: symptoms,
        notes: notes,
        followUpDate: followUpDate,
      );
      _consultations.add(consultation);
      notifyListeners();
      return true;
    } catch (e) {
      _modelError = e.toString();
      notifyListeners();
      await _dialogService.showDialog(
        title: 'Error',
        description: e.toString(),
      );
      return false;
    } finally {
      setBusy(false);
    }
  }

  Future<void> deleteConsultation(String id) async {
    try {
      setBusy(true);
      await _consultationService.deleteConsultation(id);
      _consultations.removeWhere((c) => c.id == id);
      notifyListeners();
    } catch (e) {
      _modelError = e.toString();
      notifyListeners();
      await _dialogService.showDialog(
        title: 'Error',
        description: e.toString(),
      );
    } finally {
      setBusy(false);
    }
  }
}