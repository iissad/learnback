import '../models/skill.dart';
import '../models/user_skill.dart';
import '../models/learning_goal.dart';

abstract class SkillsRepository {
  Future<List<UserSkill>> getUserSkills();
  Future<List<LearningGoal>> getUserGoals();
  Future<List<Skill>> getAllSkills();
  Future<void> addUserSkill(String skillId, String level);
  Future<void> addLearningGoal(String skillId);
}
