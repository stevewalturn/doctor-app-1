import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/services/api_service.dart';
import 'package:my_app/services/authentication_service.dart';
import 'package:my_app/services/storage_service.dart';
import 'package:my_app/services/consultation_service.dart';
import 'package:my_app/repositories/auth_repository.dart';
import 'package:my_app/repositories/consultation_repository.dart';
import 'package:my_app/repositories/dashboard_repository.dart';
import 'package:my_app/repositories/patients_repository.dart';
import 'package:my_app/features/startup/startup_view.dart';
import 'package:my_app/features/auth/login_view.dart';
import 'package:my_app/features/auth/register_view.dart';
import 'package:my_app/features/dashboard/dashboard_view.dart';
import 'package:my_app/features/patients/patients_view.dart';
import 'package:my_app/features/patients/add_patient_view.dart';
import 'package:my_app/features/consultation/consultation_view.dart';
import 'package:my_app/features/consultation/add_consultation_view.dart';
import 'package:my_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:my_app/ui/dialogs/confirmation_dialog.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: DashboardView),
    MaterialRoute(page: PatientsView),
    MaterialRoute(page: AddPatientView),
    MaterialRoute(page: ConsultationView),
    MaterialRoute(page: AddConsultationView),
  ],
  dependencies: [
    Singleton(classType: NavigationService),
    Singleton(classType: DialogService),
    Singleton(classType: BottomSheetService),
    LazySingleton(classType: ApiService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: StorageService),
    LazySingleton(classType: ConsultationService),
    LazySingleton(classType: AuthRepository),
    LazySingleton(classType: ConsultationRepository),
    LazySingleton(classType: DashboardRepository),
    LazySingleton(classType: PatientsRepository),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: ConfirmationDialog),
  ],
)
class App {}