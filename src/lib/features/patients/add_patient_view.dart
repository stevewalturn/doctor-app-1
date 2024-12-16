import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/core/constants/colors.dart';
import 'package:my_app/core/constants/text_styles.dart';
import 'package:my_app/features/patients/patients_viewmodel.dart';
import 'package:my_app/ui/widgets/custom_app_bar.dart';
import 'package:my_app/ui/widgets/custom_text_field.dart';
import 'package:my_app/ui/widgets/custom_button.dart';

class AddPatientView extends StackedView<PatientsViewModel> {
  const AddPatientView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PatientsViewModel model,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Add New Patient',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (model.modelError != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    model.modelError.toString(),
                    style: TextStyles.error,
                  ),
                ),
              CustomTextField(
                label: 'Full Name',
                hint: 'Enter patient\'s full name',
                textInputAction: TextInputAction.next,
                validator: (value) => value?.isEmpty == true
                    ? 'Please enter patient\'s name'
                    : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Date of Birth',
                      hint: 'DD/MM/YYYY',
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          value?.isEmpty == true ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      label: 'Gender',
                      hint: 'Select gender',
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          value?.isEmpty == true ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Contact Number',
                hint: 'Enter contact number',
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: (value) => value?.isEmpty == true
                    ? 'Please enter contact number'
                    : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                hint: 'Enter email address (optional)',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Address',
                hint: 'Enter complete address',
                maxLines: 3,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    value?.isEmpty == true ? 'Please enter address' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Blood Group',
                hint: 'Select blood group',
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Allergies',
                hint: 'Enter allergies (if any)',
                maxLines: 2,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Chronic Conditions',
                hint: 'Enter chronic conditions (if any)',
                maxLines: 2,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: 'Save Patient',
                onPressed: () {
                  // Handle save patient
                  Navigator.of(context).pop(true);
                },
                isLoading: model.isBusy,
                width: double.infinity,
              ),
            ],
          ),
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
}
