// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SkillTest _$SkillTestFromJson(Map<String, dynamic> json) => _SkillTest(
  id: json['_id'] as String,
  skillId: json['skillId'] as String,
  level: json['level'] as String,
  passingScore: (json['passingScore'] as num).toInt(),
  questions: (json['questions'] as List<dynamic>)
      .map((e) => TestQuestion.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SkillTestToJson(_SkillTest instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'skillId': instance.skillId,
      'level': instance.level,
      'passingScore': instance.passingScore,
      'questions': instance.questions,
    };

_TestQuestion _$TestQuestionFromJson(Map<String, dynamic> json) =>
    _TestQuestion(
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TestQuestionToJson(_TestQuestion instance) =>
    <String, dynamic>{
      'question': instance.question,
      'options': instance.options,
    };

_QuizSubmissionResponse _$QuizSubmissionResponseFromJson(
  Map<String, dynamic> json,
) => _QuizSubmissionResponse(
  score: (json['score'] as num).toInt(),
  passed: json['passed'] as bool,
  verification: json['verification'] as String?,
);

Map<String, dynamic> _$QuizSubmissionResponseToJson(
  _QuizSubmissionResponse instance,
) => <String, dynamic>{
  'score': instance.score,
  'passed': instance.passed,
  'verification': instance.verification,
};
