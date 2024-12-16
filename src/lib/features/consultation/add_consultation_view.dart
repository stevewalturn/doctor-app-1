import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/core/constants/colors.dart';
import 'package:my_app/features/consultation/consultation_viewmodel.dart';
import 'package:my_app/features/consultation/widgets/consultation_form.dart';
import 'package:my_app/ui/widgets/custom_app_bar.dart';

class AddConsultationView extends StackedView<ConsultationViewModel> {
  final String patientId;

  const AddConsultationView({
    Key? key,
    required this.patientId,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ConsultationViewModel model,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'New Consultation',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (model.modelError != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  model.modelError.toString(),
                  style: TextStyle(
                    color: AppColors.error,
                    fontSize: 14,
                  ),
                ),
              ),
            ConsultationForm(
              isLoading: model.isBusy,
              onSubmit: (data) async {
                final result = await model.createConsultation(
                  patientId: patientId,
                  chiefComplaint: data['chiefComplaint'],
                  symptoms: List<String>.from(data['symptoms']),
                  notes: data['notes'],
                  followUpDate: data['followUpDate'] != null
                      ? DateTime.parse(data['followUpDate'])
                      : null,
                );
                if (result) {
                  Navigator.of(context).pop(true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  ConsultationViewModel viewModelBuilder(BuildContext context) =>
      ConsultationViewModel(
        consultationService,
        navigationService,
        dialogService,
      );
}
