import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:learnback/features/splash/presentation/screens/splash_screen.dart';
import 'package:learnback/features/auth/presentation/screens/welcome_screen.dart';
import 'package:learnback/features/auth/presentation/screens/login_screen.dart';
import 'package:learnback/features/auth/presentation/screens/register_screen.dart';
import 'package:learnback/features/auth/presentation/screens/confirm_email_screen.dart';
import 'package:learnback/features/auth/presentation/providers/auth_provider.dart';
import 'package:learnback/features/home/presentation/screens/main_screen.dart';
import 'package:learnback/features/skills/presentation/screens/edit_mastered_skills_screen.dart';
import 'package:learnback/features/skills/presentation/screens/edit_learning_goals_screen.dart';

/// A simple [Listenable] used to notify GoRouter when the auth state changes
/// without needing to rebuild the entire GoRouter instance.
class RouterRefreshListenable extends ChangeNotifier {
  void refresh() => notifyListeners();
}

// Provides the GoRouter instance
final routerProvider = Provider<GoRouter>((ref) {
  final listenable = RouterRefreshListenable();

  // We listen to changes without "watching" the state in the body.
  // This ensures the GoRouter instance is created only once,
  // preventing the "reset back to splash" bug.
  ref.listen(authProvider, (_, _) => listenable.refresh());

  return GoRouter(
    initialLocation: '/',
    refreshListenable: listenable,
    redirect: (context, state) {
      // Securely read the latest state
      final authState = ref.read(authProvider);

      final isAuthForm =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register' ||
          state.matchedLocation == '/welcome';

      final isConfirmEmail = state.matchedLocation == '/confirm-email';
      final isSplash = state.matchedLocation == '/';

      if (authState.status == AuthStatus.authenticated) {
        // If authenticated, don't allow access to auth pages, splash, or confirm-email
        if (isAuthForm || isSplash || isConfirmEmail) {
          return '/home';
        }
      } else {
        // If not authenticated, only allow public pages
        if (!isAuthForm && !isSplash && !isConfirmEmail) {
          return '/welcome';
        }
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/confirm-email',
        builder: (context, state) => const ConfirmEmailScreen(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const MainScreen()),
      GoRoute(
        path: '/home/mastered-skills',
        builder: (context, state) => const EditMasteredSkillsScreen(),
      ),
      GoRoute(
        path: '/home/learning-goals',
        builder: (context, state) => const EditLearningGoalsScreen(),
      ),
    ],
  );
});
