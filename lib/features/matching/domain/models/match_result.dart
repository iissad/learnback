import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_result.freezed.dart';
part 'match_result.g.dart';

@freezed
abstract class MatchResult with _$MatchResult {
  const factory MatchResult({
    required String matchId,
    required String peerId,
    required String peerName,
    required String skillYouTeach,
    required String skillYouLearn,
    required String status,
    String? peerAvatar,
  }) = _MatchResult;

  factory MatchResult.fromJson(Map<String, dynamic> json) =>
      _$MatchResultFromJson(json);
}
