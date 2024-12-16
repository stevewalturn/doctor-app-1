import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/core/constants/colors.dart';
import 'package:my_app/core/constants/text_styles.dart';
import 'package:my_app/features/patients/patients_viewmodel.dart';
import 'package:my_app/features/patients/widgets/patient_card.dart';
import 'package:my_app/ui/widgets/custom_app_bar.dart';
import 'package:my_app/ui/widgets/custom_text_field.dart';
import 'package:my_app/ui/widgets/loading_indicator.dart';

class PatientsView extends StackedView<PatientsViewModel> {
  const PatientsView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, PatientsViewModel model, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Patients',
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: model.navigateToAddPatient,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomTextField(
              hint: 'Search patients...',
              prefix: const Icon(Icons.search, color: AppColors.textSecondary),
              onChanged: model.setSearchQuery,
            ),
          ),
          if (model.modelError != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                model.modelError!,
                style: TextStyles.error,
              ),
            ),
          Expanded(
            child: model.isBusy
                ? const LoadingIndicator()
                : RefreshIndicator(
                    onRefresh: model.loadPatients,
                    child: model.filteredPatients.isEmpty
                        ? Center(
                            child: Text(
                              model.searchQuery?.isNotEmpty == true
                                  ? 'No patients found matching your search'
                                  : 'No patients added yet',
                              style: TextStyles.body1.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: model.filteredPatients.length,
                            itemBuilder: (context, index) {
                              final patient = model.filteredPatients[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: PatientCard(
                                  patient: patient,
                                  onTap: () =>
                                      model.navigateToPatientDetails(patient),
                                  onDelete: () => model.deletePatient(patient),
                                ),
                              );
                            },
                          ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: model.navigateToAddPatient,
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: AppColors.white),
        label: Text(
          'Add Patient',
          style: TextStyles.button.copyWith(color: AppColors.white),
        ),
      ),
    );
  }

  @override
  PatientsViewModel viewModelBuilder(BuildContext context) => PatientsViewModel(
        patientsRepository,
        navigationService,
        dialogService,
      );

  @override
  void onViewModelReady(PatientsViewModel model) => model.initialize();
}
