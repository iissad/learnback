// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learning_goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LearningGoal {

 String get id; String get userId; String get skillId; DateTime get createdAt;
/// Create a copy of LearningGoal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearningGoalCopyWith<LearningGoal> get copyWith => _$LearningGoalCopyWithImpl<LearningGoal>(this as LearningGoal, _$identity);

  /// Serializes this LearningGoal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearningGoal&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.skillId, skillId) || other.skillId == skillId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,skillId,createdAt);

@override
String toString() {
  return 'LearningGoal(id: $id, userId: $userId, skillId: $skillId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LearningGoalCopyWith<$Res>  {
  factory $LearningGoalCopyWith(LearningGoal value, $Res Function(LearningGoal) _then) = _$LearningGoalCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String skillId, DateTime createdAt
});




}
/// @nodoc
class _$LearningGoalCopyWithImpl<$Res>
    implements $LearningGoalCopyWith<$Res> {
  _$LearningGoalCopyWithImpl(this._self, this._then);

  final LearningGoal _self;
  final $Res Function(LearningGoal) _then;

/// Create a copy of LearningGoal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? skillId = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,skillId: null == skillId ? _self.skillId : skillId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LearningGoal].
extension LearningGoalPatterns on LearningGoal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearningGoal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearningGoal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearningGoal value)  $default,){
final _that = this;
switch (_that) {
case _LearningGoal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearningGoal value)?  $default,){
final _that = this;
switch (_that) {
case _LearningGoal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String skillId,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearningGoal() when $default != null:
return $default(_that.id,_that.userId,_that.skillId,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String skillId,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _LearningGoal():
return $default(_that.id,_that.userId,_that.skillId,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String skillId,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LearningGoal() when $default != null:
return $default(_that.id,_that.userId,_that.skillId,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LearningGoal implements LearningGoal {
  const _LearningGoal({required this.id, required this.userId, required this.skillId, required this.createdAt});
  factory _LearningGoal.fromJson(Map<String, dynamic> json) => _$LearningGoalFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String skillId;
@override final  DateTime createdAt;

/// Create a copy of LearningGoal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearningGoalCopyWith<_LearningGoal> get copyWith => __$LearningGoalCopyWithImpl<_LearningGoal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LearningGoalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearningGoal&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.skillId, skillId) || other.skillId == skillId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,skillId,createdAt);

@override
String toString() {
  return 'LearningGoal(id: $id, userId: $userId, skillId: $skillId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LearningGoalCopyWith<$Res> implements $LearningGoalCopyWith<$Res> {
  factory _$LearningGoalCopyWith(_LearningGoal value, $Res Function(_LearningGoal) _then) = __$LearningGoalCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String skillId, DateTime createdAt
});




}
/// @nodoc
class __$LearningGoalCopyWithImpl<$Res>
    implements _$LearningGoalCopyWith<$Res> {
  __$LearningGoalCopyWithImpl(this._self, this._then);

  final _LearningGoal _self;
  final $Res Function(_LearningGoal) _then;

/// Create a copy of LearningGoal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? skillId = null,Object? createdAt = null,}) {
  return _then(_LearningGoal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,skillId: null == skillId ? _self.skillId : skillId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
