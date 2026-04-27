import '../models/skill.dart';
import '../models/user_skill.dart';
import '../models/learning_goal.dart';
import '../../../verification/domain/models/skill_test.dart';

abstract class SkillsRepository {
  Future<List<UserSkill>> getUserSkills();
  Future<List<LearningGoal>> getUserGoals();
  Future<List<Skill>> getAllSkills();
  Future<void> addUserSkill(String skillId, String level);
  Future<void> addLearningGoal(String skillId);

  // Verification Skills
  Future<SkillTest> getSkillTest(String skillId);
  Future<QuizSubmissionResponse> submitSkillTest(
    String testId,
    List<String> answers,
  );
}
