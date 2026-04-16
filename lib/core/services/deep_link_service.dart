import 'dart:developer';
import 'package:app_links/app_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnback/features/auth/presentation/providers/auth_provider.dart';

final deepLinkServiceProvider = Provider<void>((ref) {
  final appLinks = AppLinks();

  log('Initializing DeepLinkService');

  // Handle initial link (cold start)
  appLinks.getInitialLink().then((uri) {
    if (uri != null) {
      log('Received initial deep link: $uri');
      _handleLink(uri, ref);
    }
  });

  // Handle incoming links (warm start)
  final subscription = appLinks.uriLinkStream.listen((uri) {
    log('Received deep link: $uri');
    _handleLink(uri, ref);
  });

  ref.onDispose(() {
    log('Disposing DeepLinkService');
    subscription.cancel();
  });
});

void _handleLink(Uri uri, Ref ref) {
  // Check if the link matches our expected pattern
  if (uri.scheme == 'learnback' && uri.host == 'verify-success') {
    final jwt = uri.queryParameters['jwt'];
    if (jwt != null) {
      log('Extracted JWT from deep link, authenticating...');
      ref.read(authProvider.notifier).handleDeepLinkToken(jwt);
    }
  }
}
