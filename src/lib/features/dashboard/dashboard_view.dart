import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/core/constants/colors.dart';
import 'package:my_app/core/constants/text_styles.dart';
import 'package:my_app/features/dashboard/dashboard_viewmodel.dart';
import 'package:my_app/features/dashboard/widgets/stats_card.dart';
import 'package:my_app/ui/widgets/custom_app_bar.dart';
import 'package:my_app/ui/widgets/loading_indicator.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, DashboardViewModel model, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Dashboard',
        showBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: model.refreshDashboard,
          ),
        ],
      ),
      body: model.isBusy
          ? const LoadingIndicator()
          : RefreshIndicator(
              onRefresh: model.refreshDashboard,
              child: SingleChildScrollView(
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
                    const Text(
                      'Overview',
                      style: TextStyles.h3,
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: [
                        StatsCard(
                          title: 'Total Patients',
                          value: model.totalPatients.toString(),
                          icon: Icons.people,
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          iconColor: AppColors.primary,
                        ),
                        StatsCard(
                          title: 'Consultations',
                          value: model.totalConsultations.toString(),
                          icon: Icons.medical_services,
                          backgroundColor: AppColors.secondary.withOpacity(0.1),
                          iconColor: AppColors.secondary,
                        ),
                        StatsCard(
                          title: 'Pending',
                          value: model.pendingConsultations.toString(),
                          icon: Icons.pending_actions,
                          backgroundColor: AppColors.warning.withOpacity(0.1),
                          iconColor: AppColors.warning,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Recent Consultations',
                      style: TextStyles.h3,
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: model.recentConsultations.length,
                      itemBuilder: (context, index) {
                        final consultation = model.recentConsultations[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ListTile(
                            title: Text(consultation.chiefComplaint),
                            subtitle:
                                Text(consultation.consultationDate.toString()),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) =>
      DashboardViewModel(dashboardRepository);

  @override
  void onViewModelReady(DashboardViewModel model) => model.initialize();
}
