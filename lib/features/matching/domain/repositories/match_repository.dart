import '../models/match_result.dart';
import '../models/user_review.dart';

abstract class MatchRepository {
  Future<MatchResult> findMatch(String learnSkillId);
  Future<List<UserReview>> getUserReviews(String userId);
  Future<void> approveMatch(String matchId);
}
