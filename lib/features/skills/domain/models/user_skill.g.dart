// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSkill _$UserSkillFromJson(Map<String, dynamic> json) => _UserSkill(
  id: json['id'] as String,
  userId: json['userId'] as String,
  skillId: json['skillId'] as String,
  level: json['level'] as String,
  source: json['source'] as String,
);

Map<String, dynamic> _$UserSkillToJson(_UserSkill instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'skillId': instance.skillId,
      'level': instance.level,
      'source': instance.source,
    };
