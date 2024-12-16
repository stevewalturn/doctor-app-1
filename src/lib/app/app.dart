import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/services/api_service.dart';
import 'package:my_app/services/authentication_service.dart';
import 'package:my_app/services/storage_service.dart';
import 'package:my_app/services/consultation_service.dart';
import 'package:my_app/features/auth/auth_repository.dart';
import 'package:my_app/features/consultation/consultation_repository.dart';
import 'package:my_app/features/dashboard/dashboard_repository.dart';
import 'package:my_app/features/patients/patients_repository.dart';

import 'package:my_app/features/auth/login_view.dart';
import 'package:my_app/features/auth/register_view.dart';
import 'package:my_app/features/dashboard/dashboard_view.dart';
import 'package:my_app/features/patients/patients_view.dart';
import 'package:my_app/features/patients/add_patient_view.dart';
import 'package:my_app/features/consultation/consultation_view.dart';
import 'package:my_app/features/consultation/add_consultation_view.dart';

import 'package:my_app/ui/bottom_sheets/filter_options_sheet.dart';
import 'package:my_app/ui/dialogs/confirmation_dialog.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView, initial: true),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: DashboardView),
    MaterialRoute(page: PatientsView),
    MaterialRoute(page: AddPatientView),
    MaterialRoute(page: ConsultationView),
    MaterialRoute(page: AddConsultationView),
  ],
  dependencies: [
    InitializableSingleton(classType: AuthenticationService),
    InitializableSingleton(classType: StorageService),
    Singleton(classType: ApiService),
    InitializableSingleton(classType: ConsultationService),
    Singleton(classType: AuthRepository),
    Singleton(classType: ConsultationRepository),
    Singleton(classType: DashboardRepository),
    Singleton(classType: PatientsRepository),
    Singleton(classType: NavigationService),
    Singleton(classType: DialogService),
    Singleton(classType: BottomSheetService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: FilterOptionsSheet),
  ],
  dialogs: [
    StackedDialog(classType: ConfirmationDialog),
  ],
)
class App {}
