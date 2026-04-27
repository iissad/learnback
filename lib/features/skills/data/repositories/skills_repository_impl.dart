import 'package:dio/dio.dart';
import '../../domain/models/skill.dart';
import '../../domain/models/user_skill.dart';
import '../../domain/models/learning_goal.dart';
import '../../domain/repositories/skills_repository.dart';
import '../../../verification/domain/models/skill_test.dart';

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

  @override
  Future<List<Skill>> getAllSkills() async {
    final response = await _dio.get('skills/list');
    // Using default mapping as the structure might be `{ data: [...] }` or `[...]`.
    final responseBody = response.data;
    final List data = responseBody is Map
        ? responseBody['data'] as List
        : responseBody as List;
    return data.map((e) {
      final m = e as Map<String, dynamic>;
      return Skill.fromJson({
        'id': m['_id'] ?? m['id'] ?? '',
        'name': m['name'] ?? '',
        'description': m['description'],
        'category': m['category'],
      });
    }).toList();
  }

  @override
  Future<void> addUserSkill(String skillId, String level) async {
    await _dio.post(
      'users/addskill',
      data: {'skillId': skillId, 'level': level},
    );
  }

  @override
  Future<void> addLearningGoal(String skillId) async {
    await _dio.post('learninggoals/newgoal', data: {'skillId': skillId});
  }

  @override
  Future<SkillTest> getSkillTest(String skillId) async {
    final response = await _dio.get('tests/$skillId');
    final responseBody = response.data as Map<String, dynamic>;
    return SkillTest.fromJson(responseBody['data'] as Map<String, dynamic>);
  }

  @override
  Future<QuizSubmissionResponse> submitSkillTest(
    String testId,
    List<String> answers,
  ) async {
    final response = await _dio.post(
      'tests/$testId/take',
      data: {'answers': answers},
    );
    final responseBody = response.data as Map<String, dynamic>;
    return QuizSubmissionResponse.fromJson(
      responseBody['data'] as Map<String, dynamic>,
    );
  }
}
