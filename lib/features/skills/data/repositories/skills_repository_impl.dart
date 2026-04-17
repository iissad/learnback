import 'package:dio/dio.dart';
import '../../domain/models/user_skill.dart';
import '../../domain/models/learning_goal.dart';
import '../../domain/repositories/skills_repository.dart';

class SkillsRepositoryImpl implements SkillsRepository {
  final Dio _dio;

  SkillsRepositoryImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<UserSkill>> getUserSkills() async {
    final response = await _dio.get('users/getskill');
    final responseBody = response.data as Map<String, dynamic>;
    final List data = responseBody['data'] as List;
    return data.map((e) {
      final m = e as Map<String, dynamic>;
      // skillId is a populated object: { _id, name, category }
      final skillIdObj = m['skillId'];
      final skillId = (skillIdObj is Map)
          ? skillIdObj['_id'] as String
          : skillIdObj as String;
      return UserSkill.fromJson({
        'id': m['_id'] ?? m['id'] ?? '',
        'userId': m['userId'] ?? m['user'] ?? '',
        'skillId': skillId,
        'level': m['level'],
        'source': m['source'],
      });
    }).toList();
  }

  @override
  Future<List<LearningGoal>> getUserGoals() async {
    final response = await _dio.get('learninggoals/usergoal');
    final responseBody = response.data as Map<String, dynamic>;
    final List data = responseBody['data'] as List;
    return data.map((e) {
      final m = e as Map<String, dynamic>;
      // skillId is a populated object: { _id, name }
      final skillIdObj = m['skillId'];
      final skillId = (skillIdObj is Map)
          ? skillIdObj['_id'] as String
          : skillIdObj as String;
      return LearningGoal.fromJson({
        'id': m['_id'] ?? m['id'] ?? '',
        'userId': m['userId'] ?? m['user'] ?? '',
        'skillId': skillId,
        'createdAt': m['createdAt'] ?? DateTime.now().toIso8601String(),
      });
    }).toList();
  }
}
