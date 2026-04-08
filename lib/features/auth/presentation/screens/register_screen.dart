import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:learnback/app/theme/app_colors.dart';
import 'package:learnback/app/theme/app_text_styles.dart';
import 'package:learnback/core/constants/app_spacing.dart';
import 'package:learnback/features/auth/presentation/providers/auth_provider.dart';
import 'package:learnback/shared/widgets/auth_input_field.dart';
import 'package:learnback/shared/widgets/gradient_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  String? _passwordError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) return;

    if (password != confirm) {
      setState(() => _passwordError = 'Passwords do not match');
      return;
    }

    setState(() => _passwordError = null);

    await ref
        .read(authProvider.notifier)
        .register(name: name, email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (_, next) {
      if (next.status == AuthStatus.error && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: AppColors.error,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.darkBgPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.md),

              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.blueLight,
                  ),
                  onPressed: () => context.pop(),
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              Center(
                child: Image.asset(
                  'assets/icons/logo.png',
                  width: 140,
                  height: 140,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              const Text('Welcome', style: AppTextStyles.displayLarge),

              const SizedBox(height: AppSpacing.lg),

              AuthInputField(
                hint: 'User Name',
                controller: _nameController,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: AppSpacing.md),

              AuthInputField(
                hint: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: AppSpacing.md),

              AuthInputField(
                hint: 'Password',
                controller: _passwordController,
                isPassword: true,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: AppSpacing.md),

              AuthInputField(
                hint: 'Confirm Password',
                controller: _confirmController,
                isPassword: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _handleRegister(),
                errorText: _passwordError,
              ),

              const SizedBox(height: AppSpacing.xl),

              GradientButton(
                label: 'Next',
                isLoading: authState.isLoading,
                onPressed: _handleRegister,
              ),

              const SizedBox(height: AppSpacing.md),

              TextButton(
                onPressed: () => context.pushReplacement('/login'),
                child: Text(
                  'Log In',
                  style: AppTextStyles.headingMedium.copyWith(
                    color: AppColors.blueLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
