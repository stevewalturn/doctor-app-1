import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/core/constants/colors.dart';
import 'package:my_app/core/constants/text_styles.dart';
import 'package:my_app/features/auth/auth_viewmodel.dart';
import 'package:my_app/features/auth/widgets/auth_button.dart';
import 'package:my_app/features/auth/widgets/auth_text_field.dart';
import 'package:my_app/ui/widgets/custom_app_bar.dart';

class RegisterView extends StackedView<AuthViewModel> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, AuthViewModel model, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: 'Create Account',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Join Us',
                style: TextStyles.h2.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: 8),
              Text(
                'Complete your details to get started',
                style:
                    TextStyles.body1.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              AuthTextField(
                label: 'Full Name',
                hint: 'Enter your full name',
                onChanged: model.setName,
                errorText: model.modelError,
              ),
              const SizedBox(height: 24),
              AuthTextField(
                label: 'Email',
                hint: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                onChanged: model.setEmail,
                errorText: model.modelError,
              ),
              const SizedBox(height: 24),
              AuthTextField(
                label: 'Specialization',
                hint: 'Enter your medical specialization',
                onChanged: model.setSpecialization,
                errorText: model.modelError,
              ),
              const SizedBox(height: 24),
              AuthTextField(
                label: 'Password',
                hint: 'Create a password',
                isPassword: true,
                textInputAction: TextInputAction.done,
                onChanged: model.setPassword,
                errorText: model.modelError,
              ),
              const SizedBox(height: 32),
              AuthButton(
                text: 'Register',
                onPressed: model.register,
                isLoading: model.isBusy,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyles.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextButton(
                    onPressed: model.navigateToLogin,
                    child: Text(
                      'Login',
                      style: TextStyles.body2.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AuthViewModel viewModelBuilder(BuildContext context) => AuthViewModel(
        authenticationService,
        navigationService,
        dialogService,
      );
}
