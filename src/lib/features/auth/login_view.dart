import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/core/constants/colors.dart';
import 'package:my_app/core/constants/text_styles.dart';
import 'package:my_app/features/auth/auth_viewmodel.dart';
import 'package:my_app/features/auth/widgets/auth_button.dart';
import 'package:my_app/features/auth/widgets/auth_text_field.dart';

class LoginView extends StackedView<AuthViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, AuthViewModel model, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Welcome Back',
                style: TextStyles.h1.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue',
                style:
                    TextStyles.body1.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 40),
              AuthTextField(
                label: 'Email',
                hint: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                onChanged: model.setEmail,
                errorText: model.modelError,
              ),
              const SizedBox(height: 24),
              AuthTextField(
                label: 'Password',
                hint: 'Enter your password',
                isPassword: true,
                textInputAction: TextInputAction.done,
                onChanged: model.setPassword,
                errorText: model.modelError,
              ),
              const SizedBox(height: 32),
              AuthButton(
                text: 'Login',
                onPressed: model.login,
                isLoading: model.isBusy,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyles.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextButton(
                    onPressed: model.navigateToRegister,
                    child: Text(
                      'Register',
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
