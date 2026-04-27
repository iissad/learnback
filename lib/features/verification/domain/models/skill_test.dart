import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill_test.freezed.dart';
part 'skill_test.g.dart';

@freezed
abstract class SkillTest with _$SkillTest {
  const factory SkillTest({
    // ignore: invalid_annotation_target
    @JsonKey(name: '_id') required String id,
    required String skillId,
    required String level,
    required int passingScore,
    required List<TestQuestion> questions,
  }) = _SkillTest;

  factory SkillTest.fromJson(Map<String, dynamic> json) =>
      _$SkillTestFromJson(json);
}

@freezed
abstract class TestQuestion with _$TestQuestion {
  const factory TestQuestion({
    required String question,
    required List<String> options,
  }) = _TestQuestion;

  factory TestQuestion.fromJson(Map<String, dynamic> json) =>
      _$TestQuestionFromJson(json);
}

@freezed
abstract class QuizSubmissionResponse with _$QuizSubmissionResponse {
  const factory QuizSubmissionResponse({
    required int score,
    required bool passed,
    String? verification,
  }) = _QuizSubmissionResponse;

  factory QuizSubmissionResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizSubmissionResponseFromJson(json);
}
