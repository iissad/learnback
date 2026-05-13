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

      // Mapping the response to MatchResult.
      // The API returns userBId, teachSkillAId, teachSkillBId etc.
      // We map them to our domestic model.
      return MatchResult.fromJson({
        'matchId': data['_id'] ?? data['id'] ?? '',
        'peerId': data['userBId'] ?? '',
        'peerName':
            data['peerName'] ??
            'Matching Peer', // peerName might not be in the direct find response, but usually backend populates or we might need another call. In this context, we assume it's there or we provide a default.
        'skillYouTeach': data['teachSkillAId'] ?? '',
        'skillYouLearn': data['teachSkillBId'] ?? '',
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
      final List data = response.data['data'] as List;
      return data.map((e) {
        final m = e as Map<String, dynamic>;
        final reviewer = m['reviewerId'] as Map<String, dynamic>?;
        return UserReview.fromJson({
          'rating': m['rating'],
          'review': m['review'],
          'comment': m['comment'],
          'reviewerName': reviewer?['name'],
          'reviewerEmail': reviewer?['email'],
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
