import 'package:dio/dio.dart';
import '../../domain/models/user_skill.dart';
import '../../domain/models/learning_goal.dart';
import '../../domain/repositories/skills_repository.dart';

class SkillsRepositoryImpl implements SkillsRepository {
  final Dio _dio;

  SkillsRepositoryImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<UserSkill>> getUserSkills() async {
    final response = await _dio.get('users/skills');
    final List data = response.data;
    return data.map((e) => UserSkill.fromJson(e)).toList();
  }

  @override
  Future<List<LearningGoal>> getUserGoals() async {
    final response = await _dio.get('users/goals');
    final List data = response.data;
    return data.map((e) => LearningGoal.fromJson(e)).toList();
  }
}
