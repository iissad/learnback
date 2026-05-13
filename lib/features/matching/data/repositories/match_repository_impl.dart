import 'package:dio/dio.dart';
import '../../domain/models/match_result.dart';
import '../../domain/models/user_review.dart';
import '../../domain/repositories/match_repository.dart';

class MatchRepositoryImpl implements MatchRepository {
  final Dio _dio;

  MatchRepositoryImpl({required Dio dio}) : _dio = dio;

  @override
  Future<MatchResult> findMatch(String learnSkillId) async {
    try {
      final response = await _dio.post(
        'match/find',
        data: {'learnSkillId': learnSkillId},
      );

      final dynamic data = response.data['data'];

      final userB = data['userBId'] as Map<String, dynamic>;
      final skillA = data['teachSkillAId'] as Map<String, dynamic>;
      final skillB = data['teachSkillBId'] as Map<String, dynamic>;
      final profileB = userB['profile'] as Map<String, dynamic>?;

      return MatchResult.fromJson({
        'matchId': data['_id'] ?? data['id'] ?? '',
        'peerId': userB['_id'] ?? userB['id'] ?? '',
        'peerName': userB['name'] ?? 'Matching Peer',
        'peerAvatar': profileB?['avatar'],
        'skillYouTeach': skillA['name'] ?? '',
        'skillYouLearn': skillB['name'] ?? '',
        'status': data['status'] ?? 'pending',
      });
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<List<UserReview>> getUserReviews(String userId) async {
    try {
      final response = await _dio.get('users/$userId/userreviews');
      final List<dynamic> data = response.data['data'];
      return data.map((review) {
        final reviewer = review['reviewerId'];
        String reviewerName = 'Peer';
        if (reviewer is Map) {
          reviewerName = reviewer['name'] ?? 'Peer';
        }

        return UserReview.fromJson({
          'id': review['_id'] ?? review['id'] ?? '',
          'rating': (review['rating'] as num?)?.toInt() ?? 0,
          'review': review['review'] ?? 'good',
          'comment': review['comment'],
          'reviewerName': reviewerName,
          'createdAt': review['createdAt'],
        });
      }).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> approveMatch(String matchId) async {
    try {
      await _dio.put('match/$matchId/approve-match');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  String _handleDioError(DioException e) {
    if (e.response?.data != null && e.response?.data is Map) {
      final data = e.response?.data as Map;
      if (data.containsKey('error')) return data['error'].toString();
      if (data.containsKey('message')) return data['message'].toString();
    }
    return e.message ?? 'An unexpected error occurred';
  }
}
