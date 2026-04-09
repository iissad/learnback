import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:learnback/features/splash/presentation/screens/splash_screen.dart';
import 'package:learnback/features/auth/presentation/screens/welcome_screen.dart';
import 'package:learnback/features/auth/presentation/screens/login_screen.dart';
import 'package:learnback/features/auth/presentation/screens/register_screen.dart';
import 'package:learnback/features/auth/presentation/screens/confirm_email_screen.dart';
import 'package:learnback/features/auth/presentation/providers/auth_provider.dart';
import 'package:learnback/features/home/presentation/screens/main_screen.dart';

// Provides the GoRouter instance
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isAuth =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register' ||
          state.matchedLocation == '/welcome';

      final isConfirmEmail = state.matchedLocation == '/confirm-email';
      final isSplash = state.matchedLocation == '/';

      if (authState.status == AuthStatus.authenticated) {
        // If authenticated, don't allow access to auth pages or splash
        if (isAuth || isSplash) {
          return '/home';
        }
      } else {
        // If not authenticated, don't allow access to protected pages
        if (!isAuth && !isSplash && !isConfirmEmail) {
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
    ],
  );
});
