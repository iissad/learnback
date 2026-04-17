import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_skill.freezed.dart';
part 'user_skill.g.dart';

@freezed
class UserSkill with _$UserSkill {
  const factory UserSkill({
    required String id,
    required String userId,
    required String skillId,
    required String level,
    required String source,
  }) = _UserSkill;

  factory UserSkill.fromJson(Map<String, dynamic> json) =>
      _$UserSkillFromJson(json);
}
