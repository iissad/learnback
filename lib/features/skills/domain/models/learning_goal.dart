import 'package:freezed_annotation/freezed_annotation.dart';

part 'learning_goal.freezed.dart';
part 'learning_goal.g.dart';

@freezed
abstract class LearningGoal with _$LearningGoal {
  const factory LearningGoal({
    required String id,
    required String userId,
    required String skillId,
    required DateTime createdAt,
  }) = _LearningGoal;

  factory LearningGoal.fromJson(Map<String, dynamic> json) =>
      _$LearningGoalFromJson(json);
}
