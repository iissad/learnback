// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserReview _$UserReviewFromJson(Map<String, dynamic> json) => _UserReview(
  rating: (json['rating'] as num).toInt(),
  review: json['review'] as String,
  comment: json['comment'] as String?,
  reviewerName: json['reviewerName'] as String?,
  reviewerEmail: json['reviewerEmail'] as String?,
  reviewerAvatar: json['reviewerAvatar'] as String?,
);

Map<String, dynamic> _$UserReviewToJson(_UserReview instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'review': instance.review,
      'comment': instance.comment,
      'reviewerName': instance.reviewerName,
      'reviewerEmail': instance.reviewerEmail,
      'reviewerAvatar': instance.reviewerAvatar,
    };
