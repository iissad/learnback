import 'dart:async';
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

/// A simple [Listenable] that notifies listeners whenever an [AsyncValue] or
/// any other stream changes. Used to trigger GoRouter redirections.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

// Provides the GoRouter instance
final routerProvider = Provider<GoRouter>((ref) {
  // We use listenable to trigger redirects without rebuilding the whole router
  final refreshListenable = GoRouterRefreshStream(
    ref.watch(authProvider.notifier).stream,
  );

  return GoRouter(
    initialLocation: '/',
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      // Use ref.read to get the latest state without subscribing to rebuilds here
      final authState = ref.read(authProvider);

      final isAuthForm =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register' ||
          state.matchedLocation == '/welcome';

      final isConfirmEmail = state.matchedLocation == '/confirm-email';
      final isSplash = state.matchedLocation == '/';

      if (authState.status == AuthStatus.authenticated) {
        // If authenticated, don't allow access to auth pages or splash
        if (isAuthForm || isSplash) {
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
    ],
  );
});
