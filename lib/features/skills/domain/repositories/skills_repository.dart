import '../models/user_skill.dart';
import '../models/learning_goal.dart';

abstract class SkillsRepository {
  Future<List<UserSkill>> getUserSkills();
  Future<List<LearningGoal>> getUserGoals();
}
