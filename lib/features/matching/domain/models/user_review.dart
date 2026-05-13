import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_review.freezed.dart';
part 'user_review.g.dart';

@freezed
abstract class UserReview with _$UserReview {
  const factory UserReview({
    required int rating,
    required String review,
    String? comment,
    String? reviewerName,
    String? reviewerEmail,
    String? reviewerAvatar,
  }) = _UserReview;

  factory UserReview.fromJson(Map<String, dynamic> json) =>
      _$UserReviewFromJson(json);
}
