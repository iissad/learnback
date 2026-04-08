import 'package:go_router/go_router.dart';

import 'package:learnback/features/splash/presentation/screens/splash_screen.dart';
import 'package:learnback/features/auth/presentation/screens/welcome_screen.dart';
import 'package:learnback/features/auth/presentation/screens/login_screen.dart';
import 'package:learnback/features/auth/presentation/screens/register_screen.dart';

// Provides the GoRouter instance
final goRouter = GoRouter(
  initialLocation: '/',
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
  ],
);
