import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/core/constants/colors.dart';
import 'package:my_app/core/constants/text_styles.dart';
import 'package:my_app/features/consultation/consultation_viewmodel.dart';
import 'package:my_app/ui/widgets/custom_app_bar.dart';
import 'package:my_app/ui/widgets/loading_indicator.dart';
import 'package:my_app/ui/widgets/custom_button.dart';

class ConsultationView extends StackedView<ConsultationViewModel> {
  final String consultationId;

  const ConsultationView({
    Key? key,
    required this.consultationId,
  }) : super(key: key);

  @override
  Widget builder(
      BuildContext context, ConsultationViewModel model, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Consultation Details',
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => model.deleteConsultation(consultationId),
          ),
        ],
      ),
      body: model.isBusy
          ? const LoadingIndicator()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (model.modelError != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        model.modelError!,
                        style: TextStyles.error,
                      ),
                    ),
                  if (model.selectedConsultation != null) ...[
                    _buildConsultationHeader(model),
                    const SizedBox(height: 24),
                    _buildDiagnosisSection(model),
                  ],
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDiagnosisBottomSheet(context, model),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: AppColors.white),
        label: Text(
          'Add Diagnosis',
          style: TextStyles.button.copyWith(color: AppColors.white),
        ),
      ),
    );
  }

  Widget _buildConsultationHeader(ConsultationViewModel model) {
    final consultation = model.selectedConsultation!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chief Complaint',
              style: TextStyles.h4,
            ),
            const SizedBox(height: 8),
            Text(
              consultation.chiefComplaint,
              style: TextStyles.body1,
            ),
            const SizedBox(height: 16),
            Text(
              'Symptoms',
              style: TextStyles.h4,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: consultation.symptoms
                  .map((symptom) => Chip(
                        label: Text(symptom),
                        backgroundColor: AppColors.primaryLight,
                        labelStyle: TextStyles.body2.copyWith(
                          color: AppColors.white,
                        ),
                      ))
                  .toList(),
            ),
            if (consultation.notes != null) ...[
              const SizedBox(height: 16),
              Text(
                'Notes',
                style: TextStyles.h4,
              ),
              const SizedBox(height: 8),
              Text(
                consultation.notes!,
                style: TextStyles.body1,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosisSection(ConsultationViewModel model) {
    final diagnoses = model.selectedConsultation!.diagnoses;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Diagnoses',
          style: TextStyles.h3,
        ),
        const SizedBox(height: 16),
        if (diagnoses.isEmpty)
          Center(
            child: Text(
              'No diagnoses added yet',
              style: TextStyles.body1.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: diagnoses.length,
            itemBuilder: (context, index) {
              final diagnosis = diagnoses[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  title: Text(
                    diagnosis.condition,
                    style: TextStyles.h4,
                  ),
                  subtitle: Text(
                    diagnosis.description,
                    style: TextStyles.body2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDiagnosisDetail(
                              'Treatments', diagnosis.treatments),
                          const SizedBox(height: 16),
                          _buildDiagnosisDetail(
                              'Medications', diagnosis.medications),
                          if (diagnosis.notes.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Text(
                              'Notes',
                              style: TextStyles.label,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              diagnosis.notes,
                              style: TextStyles.body1,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildDiagnosisDetail(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.label,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items
              .map((item) => Chip(
                    label: Text(item),
                    backgroundColor: AppColors.surfaceLight,
                  ))
              .toList(),
        ),
      ],
    );
  }

  void _showAddDiagnosisBottomSheet(
      BuildContext context, ConsultationViewModel model) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Diagnosis',
                style: TextStyles.h3,
              ),
              const SizedBox(height: 24),
              // Add diagnosis form here
              CustomButton(
                text: 'Save Diagnosis',
                onPressed: () {
                  // Handle save diagnosis
                  Navigator.pop(context);
                },
              ),
            ],
          ),
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

  @override
  void onViewModelReady(ConsultationViewModel model) =>
      model.selectConsultation(consultationId);
}
