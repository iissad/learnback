// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LearningGoal _$LearningGoalFromJson(Map<String, dynamic> json) =>
    _LearningGoal(
      id: json['id'] as String,
      userId: json['userId'] as String,
      skillId: json['skillId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$LearningGoalToJson(_LearningGoal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'skillId': instance.skillId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
