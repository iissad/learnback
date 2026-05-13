// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchResult _$MatchResultFromJson(Map<String, dynamic> json) => _MatchResult(
  matchId: json['matchId'] as String,
  peerId: json['peerId'] as String,
  peerName: json['peerName'] as String,
  skillYouTeach: json['skillYouTeach'] as String,
  skillYouLearn: json['skillYouLearn'] as String,
  status: json['status'] as String,
  peerAvatar: json['peerAvatar'] as String?,
);

Map<String, dynamic> _$MatchResultToJson(_MatchResult instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'peerId': instance.peerId,
      'peerName': instance.peerName,
      'skillYouTeach': instance.skillYouTeach,
      'skillYouLearn': instance.skillYouLearn,
      'status': instance.status,
      'peerAvatar': instance.peerAvatar,
    };
