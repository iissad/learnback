// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserReview {

 int get rating; String get review; String? get comment; String? get reviewerName; String? get reviewerEmail; String? get reviewerAvatar;
/// Create a copy of UserReview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserReviewCopyWith<UserReview> get copyWith => _$UserReviewCopyWithImpl<UserReview>(this as UserReview, _$identity);

  /// Serializes this UserReview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserReview&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.review, review) || other.review == review)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.reviewerEmail, reviewerEmail) || other.reviewerEmail == reviewerEmail)&&(identical(other.reviewerAvatar, reviewerAvatar) || other.reviewerAvatar == reviewerAvatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,review,comment,reviewerName,reviewerEmail,reviewerAvatar);

@override
String toString() {
  return 'UserReview(rating: $rating, review: $review, comment: $comment, reviewerName: $reviewerName, reviewerEmail: $reviewerEmail, reviewerAvatar: $reviewerAvatar)';
}


}

/// @nodoc
abstract mixin class $UserReviewCopyWith<$Res>  {
  factory $UserReviewCopyWith(UserReview value, $Res Function(UserReview) _then) = _$UserReviewCopyWithImpl;
@useResult
$Res call({
 int rating, String review, String? comment, String? reviewerName, String? reviewerEmail, String? reviewerAvatar
});




}
/// @nodoc
class _$UserReviewCopyWithImpl<$Res>
    implements $UserReviewCopyWith<$Res> {
  _$UserReviewCopyWithImpl(this._self, this._then);

  final UserReview _self;
  final $Res Function(UserReview) _then;

/// Create a copy of UserReview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rating = null,Object? review = null,Object? comment = freezed,Object? reviewerName = freezed,Object? reviewerEmail = freezed,Object? reviewerAvatar = freezed,}) {
  return _then(_self.copyWith(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as String,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,reviewerName: freezed == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String?,reviewerEmail: freezed == reviewerEmail ? _self.reviewerEmail : reviewerEmail // ignore: cast_nullable_to_non_nullable
as String?,reviewerAvatar: freezed == reviewerAvatar ? _self.reviewerAvatar : reviewerAvatar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserReview].
extension UserReviewPatterns on UserReview {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserReview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserReview() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserReview value)  $default,){
final _that = this;
switch (_that) {
case _UserReview():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserReview value)?  $default,){
final _that = this;
switch (_that) {
case _UserReview() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rating,  String review,  String? comment,  String? reviewerName,  String? reviewerEmail,  String? reviewerAvatar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserReview() when $default != null:
return $default(_that.rating,_that.review,_that.comment,_that.reviewerName,_that.reviewerEmail,_that.reviewerAvatar);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rating,  String review,  String? comment,  String? reviewerName,  String? reviewerEmail,  String? reviewerAvatar)  $default,) {final _that = this;
switch (_that) {
case _UserReview():
return $default(_that.rating,_that.review,_that.comment,_that.reviewerName,_that.reviewerEmail,_that.reviewerAvatar);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rating,  String review,  String? comment,  String? reviewerName,  String? reviewerEmail,  String? reviewerAvatar)?  $default,) {final _that = this;
switch (_that) {
case _UserReview() when $default != null:
return $default(_that.rating,_that.review,_that.comment,_that.reviewerName,_that.reviewerEmail,_that.reviewerAvatar);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserReview implements UserReview {
  const _UserReview({required this.rating, required this.review, this.comment, this.reviewerName, this.reviewerEmail, this.reviewerAvatar});
  factory _UserReview.fromJson(Map<String, dynamic> json) => _$UserReviewFromJson(json);

@override final  int rating;
@override final  String review;
@override final  String? comment;
@override final  String? reviewerName;
@override final  String? reviewerEmail;
@override final  String? reviewerAvatar;

/// Create a copy of UserReview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserReviewCopyWith<_UserReview> get copyWith => __$UserReviewCopyWithImpl<_UserReview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserReviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserReview&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.review, review) || other.review == review)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.reviewerEmail, reviewerEmail) || other.reviewerEmail == reviewerEmail)&&(identical(other.reviewerAvatar, reviewerAvatar) || other.reviewerAvatar == reviewerAvatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rating,review,comment,reviewerName,reviewerEmail,reviewerAvatar);

@override
String toString() {
  return 'UserReview(rating: $rating, review: $review, comment: $comment, reviewerName: $reviewerName, reviewerEmail: $reviewerEmail, reviewerAvatar: $reviewerAvatar)';
}


}

/// @nodoc
abstract mixin class _$UserReviewCopyWith<$Res> implements $UserReviewCopyWith<$Res> {
  factory _$UserReviewCopyWith(_UserReview value, $Res Function(_UserReview) _then) = __$UserReviewCopyWithImpl;
@override @useResult
$Res call({
 int rating, String review, String? comment, String? reviewerName, String? reviewerEmail, String? reviewerAvatar
});




}
/// @nodoc
class __$UserReviewCopyWithImpl<$Res>
    implements _$UserReviewCopyWith<$Res> {
  __$UserReviewCopyWithImpl(this._self, this._then);

  final _UserReview _self;
  final $Res Function(_UserReview) _then;

/// Create a copy of UserReview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rating = null,Object? review = null,Object? comment = freezed,Object? reviewerName = freezed,Object? reviewerEmail = freezed,Object? reviewerAvatar = freezed,}) {
  return _then(_UserReview(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as String,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,reviewerName: freezed == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String?,reviewerEmail: freezed == reviewerEmail ? _self.reviewerEmail : reviewerEmail // ignore: cast_nullable_to_non_nullable
as String?,reviewerAvatar: freezed == reviewerAvatar ? _self.reviewerAvatar : reviewerAvatar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
