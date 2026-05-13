// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchResult {

 String get matchId; String get peerId; String get peerName; String get skillYouTeach; String get skillYouLearn; String get status; String? get peerAvatar;
/// Create a copy of MatchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchResultCopyWith<MatchResult> get copyWith => _$MatchResultCopyWithImpl<MatchResult>(this as MatchResult, _$identity);

  /// Serializes this MatchResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchResult&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.peerId, peerId) || other.peerId == peerId)&&(identical(other.peerName, peerName) || other.peerName == peerName)&&(identical(other.skillYouTeach, skillYouTeach) || other.skillYouTeach == skillYouTeach)&&(identical(other.skillYouLearn, skillYouLearn) || other.skillYouLearn == skillYouLearn)&&(identical(other.status, status) || other.status == status)&&(identical(other.peerAvatar, peerAvatar) || other.peerAvatar == peerAvatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchId,peerId,peerName,skillYouTeach,skillYouLearn,status,peerAvatar);

@override
String toString() {
  return 'MatchResult(matchId: $matchId, peerId: $peerId, peerName: $peerName, skillYouTeach: $skillYouTeach, skillYouLearn: $skillYouLearn, status: $status, peerAvatar: $peerAvatar)';
}


}

/// @nodoc
abstract mixin class $MatchResultCopyWith<$Res>  {
  factory $MatchResultCopyWith(MatchResult value, $Res Function(MatchResult) _then) = _$MatchResultCopyWithImpl;
@useResult
$Res call({
 String matchId, String peerId, String peerName, String skillYouTeach, String skillYouLearn, String status, String? peerAvatar
});




}
/// @nodoc
class _$MatchResultCopyWithImpl<$Res>
    implements $MatchResultCopyWith<$Res> {
  _$MatchResultCopyWithImpl(this._self, this._then);

  final MatchResult _self;
  final $Res Function(MatchResult) _then;

/// Create a copy of MatchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matchId = null,Object? peerId = null,Object? peerName = null,Object? skillYouTeach = null,Object? skillYouLearn = null,Object? status = null,Object? peerAvatar = freezed,}) {
  return _then(_self.copyWith(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,peerId: null == peerId ? _self.peerId : peerId // ignore: cast_nullable_to_non_nullable
as String,peerName: null == peerName ? _self.peerName : peerName // ignore: cast_nullable_to_non_nullable
as String,skillYouTeach: null == skillYouTeach ? _self.skillYouTeach : skillYouTeach // ignore: cast_nullable_to_non_nullable
as String,skillYouLearn: null == skillYouLearn ? _self.skillYouLearn : skillYouLearn // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,peerAvatar: freezed == peerAvatar ? _self.peerAvatar : peerAvatar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchResult].
extension MatchResultPatterns on MatchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchResult value)  $default,){
final _that = this;
switch (_that) {
case _MatchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchResult value)?  $default,){
final _that = this;
switch (_that) {
case _MatchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String matchId,  String peerId,  String peerName,  String skillYouTeach,  String skillYouLearn,  String status,  String? peerAvatar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchResult() when $default != null:
return $default(_that.matchId,_that.peerId,_that.peerName,_that.skillYouTeach,_that.skillYouLearn,_that.status,_that.peerAvatar);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String matchId,  String peerId,  String peerName,  String skillYouTeach,  String skillYouLearn,  String status,  String? peerAvatar)  $default,) {final _that = this;
switch (_that) {
case _MatchResult():
return $default(_that.matchId,_that.peerId,_that.peerName,_that.skillYouTeach,_that.skillYouLearn,_that.status,_that.peerAvatar);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String matchId,  String peerId,  String peerName,  String skillYouTeach,  String skillYouLearn,  String status,  String? peerAvatar)?  $default,) {final _that = this;
switch (_that) {
case _MatchResult() when $default != null:
return $default(_that.matchId,_that.peerId,_that.peerName,_that.skillYouTeach,_that.skillYouLearn,_that.status,_that.peerAvatar);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchResult implements MatchResult {
  const _MatchResult({required this.matchId, required this.peerId, required this.peerName, required this.skillYouTeach, required this.skillYouLearn, required this.status, this.peerAvatar});
  factory _MatchResult.fromJson(Map<String, dynamic> json) => _$MatchResultFromJson(json);

@override final  String matchId;
@override final  String peerId;
@override final  String peerName;
@override final  String skillYouTeach;
@override final  String skillYouLearn;
@override final  String status;
@override final  String? peerAvatar;

/// Create a copy of MatchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchResultCopyWith<_MatchResult> get copyWith => __$MatchResultCopyWithImpl<_MatchResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchResult&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.peerId, peerId) || other.peerId == peerId)&&(identical(other.peerName, peerName) || other.peerName == peerName)&&(identical(other.skillYouTeach, skillYouTeach) || other.skillYouTeach == skillYouTeach)&&(identical(other.skillYouLearn, skillYouLearn) || other.skillYouLearn == skillYouLearn)&&(identical(other.status, status) || other.status == status)&&(identical(other.peerAvatar, peerAvatar) || other.peerAvatar == peerAvatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchId,peerId,peerName,skillYouTeach,skillYouLearn,status,peerAvatar);

@override
String toString() {
  return 'MatchResult(matchId: $matchId, peerId: $peerId, peerName: $peerName, skillYouTeach: $skillYouTeach, skillYouLearn: $skillYouLearn, status: $status, peerAvatar: $peerAvatar)';
}


}

/// @nodoc
abstract mixin class _$MatchResultCopyWith<$Res> implements $MatchResultCopyWith<$Res> {
  factory _$MatchResultCopyWith(_MatchResult value, $Res Function(_MatchResult) _then) = __$MatchResultCopyWithImpl;
@override @useResult
$Res call({
 String matchId, String peerId, String peerName, String skillYouTeach, String skillYouLearn, String status, String? peerAvatar
});




}
/// @nodoc
class __$MatchResultCopyWithImpl<$Res>
    implements _$MatchResultCopyWith<$Res> {
  __$MatchResultCopyWithImpl(this._self, this._then);

  final _MatchResult _self;
  final $Res Function(_MatchResult) _then;

/// Create a copy of MatchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matchId = null,Object? peerId = null,Object? peerName = null,Object? skillYouTeach = null,Object? skillYouLearn = null,Object? status = null,Object? peerAvatar = freezed,}) {
  return _then(_MatchResult(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,peerId: null == peerId ? _self.peerId : peerId // ignore: cast_nullable_to_non_nullable
as String,peerName: null == peerName ? _self.peerName : peerName // ignore: cast_nullable_to_non_nullable
as String,skillYouTeach: null == skillYouTeach ? _self.skillYouTeach : skillYouTeach // ignore: cast_nullable_to_non_nullable
as String,skillYouLearn: null == skillYouLearn ? _self.skillYouLearn : skillYouLearn // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,peerAvatar: freezed == peerAvatar ? _self.peerAvatar : peerAvatar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
