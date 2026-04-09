import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learnback/core/constants/app_spacing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Show splash for at least 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // We don't need to manually navigate here if GoRouter is listening to AuthState,
    // but we can trigger a refresh or just go to /login if still unknown.
    // However, the redirect logic in routerProvider will now handle this.
    // To be safe, we can just trigger a go('/') to re-evaluate redirect if needed,
    // but context.go('/welcome') is fine as a fallback.
    context.go('/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF0B1221,
      ), // Dark profile background matching logo
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Image
            Image.asset(
              'assets/icons/logo.png',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: AppSpacing.lg),

            // App Name
            const Text(
              'LearnBack',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            // Subtitle
            const Text(
              'Amplify your skills. Connect. Learn. Empower.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
