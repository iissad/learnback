import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_review.dart';
import 'matching_provider.dart';

final userReviewsProvider = FutureProvider.family<List<UserReview>, String>((
  ref,
  userId,
) async {
  final repo = ref.watch(matchRepositoryProvider);
  return repo.getUserReviews(userId);
});
