import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnback/app/router.dart';
import 'package:learnback/app/theme/app_theme.dart';
import 'package:learnback/core/services/deep_link_service.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize deep link handling
    ref.watch(deepLinkServiceProvider);

    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'LearnBack',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
